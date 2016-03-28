//
//  OSMOAdvanceView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOAdvanceView.h"
#import "Masonry.h"
#import "DJIIPhoneCameraModel.h"
#import "DJIIPhoneCameraView.h"
#import "OSMOCaptureToolView.h"


@interface OSMOAdvanceView()
@property(nonatomic,strong) UIButton    *buttonAdvance;
@end

@implementation OSMOAdvanceView

-(void) initViews
{
    _buttonAdvance = [[UIButton alloc] init];
    [self addSubview:_buttonAdvance];
    _buttonAdvance.backgroundColor = [UIColor clearColor];
    
    [_buttonAdvance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(OSMO_ICON_WIDTH, OSMO_ICON_HEIGHT));
    }];
    
    _buttonAdvance.userInteractionEnabled = YES;

    if(_buttonAdvance){
        [_buttonAdvance addTarget:self.camera action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        assert(0);
    }
    
    [_buttonAdvance setImage:[UIImage imageNamed:@"captureTool_pasm_pmode_off"] forState:UIControlStateNormal];
    [_buttonAdvance setImage:[UIImage imageNamed:@"captureTool_pasm_pmode_on"] forState:UIControlStateSelected];
    [_buttonAdvance addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self reloadSkins];
}

-(void) reloadSkins
{}

- (void)buttonClick:(UIButton *)button {
    button.selected = !button.selected;
    [self reloadSkins];
    
    if(self.camera){}
}
@end
