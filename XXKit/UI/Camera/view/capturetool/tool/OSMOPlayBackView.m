//
//  OSMOPlayBackView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOPlayBackView.h"
#import "Masonry.h"
#import "DJIIPhoneCameraModel.h"
#import "DJIIPhoneCameraView.h"
#import "OSMOEventAction.h"
#import "OSMOCaptureToolView.h"

@interface OSMOPlayBackView()

@property(nonatomic,strong) UIButton  *buttonPlayBack;

@end


@implementation OSMOPlayBackView


-(void) initViews
{
    _buttonPlayBack = [[UIButton alloc] init];
    [self addSubview:_buttonPlayBack];
    _buttonPlayBack.backgroundColor = [UIColor clearColor];
    
    [_buttonPlayBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(OSMO_ICON_WIDTH, OSMO_ICON_HEIGHT));
    }];
    
    _buttonPlayBack.userInteractionEnabled = YES;
    
    [_buttonPlayBack setImage:[UIImage imageNamed:@"handle_playback"] forState:UIControlStateNormal];
    
    [_buttonPlayBack addTarget:self.cameraAction action:@selector(actionClick_PlayBackButton_OSMOPlayBackView) forControlEvents:UIControlEventTouchUpInside];
    

    [self reloadSkins];
}

-(void) reloadSkins{}

@end
