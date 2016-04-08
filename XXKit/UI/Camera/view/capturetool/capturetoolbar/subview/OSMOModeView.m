//
//  OSMOModeView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOView.h"
#import "OSMOModeView.h"
#import "Masonry.h"
#import "DJIIPhoneCameraModel.h"
#import "OSMOCaptureToolView.h"
#import "UIDevice+DJIUIKit.h"
#import "OSMOStateButton.h"

@interface OSMOModeView()

@property(nonatomic,strong) OSMOStateButton *modeButton;
@property(nonatomic,strong) UIImageView *imageArrow;

@end


@implementation OSMOModeView

- (void)initData{}
-(void) initViews
{
    _modeButton = [[OSMOStateButton alloc] init];
    [self addSubview:_modeButton];
    [_modeButton setStateIconNormal:@"handleCameraOff" iconSelected:@"handleCameraOn"];
    
    _imageArrow = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageArrow.image = [UIImage imageNamed:@"handleArrowLandscapeOff"];
    _imageArrow.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageArrow];
    
    [_modeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(OSMOModeView_BUTTON_WIDTH, OSMOModeView_BUTTON_HEIGHT));
    }];
    
    [self reloadSkins];
}
- (void)initEvent{
    [_modeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}



-(void) layoutLandscape
{
    _imageArrow.frame = CGRectMake(OSMOModeView_IMAGE_LANDSCAPE_X, OSMOModeView_IMAGE_LANDSCAPE_Y, OSMOModeView_IMAGE_WIDTH, OSMOModeView_IMAGE_HEIGHT);
    if(_modeButton.selected){
        _imageArrow.image = [UIImage imageNamed:@"handleArrowLandscapeOn"];
    }else{
        _imageArrow.image = [UIImage imageNamed:@"handleArrowLandscapeOff"];
    }
}

-(void) layoutPortrait
{
    _imageArrow.frame = CGRectMake(OSMOModeView_IMAGE_PORTRAIT_X, OSMOModeView_IMAGE_PORTRAIT_Y, OSMOModeView_IMAGE_PORTRAIT_WIDTH, OSMOModeView_IMAGE_PORTRAIT_HEIGHT);
    if(_modeButton.selected){
        _imageArrow.image = [UIImage imageNamed:@"handleArrowPotraitOn"];
    }else{
        _imageArrow.image = [UIImage imageNamed:@"handleArrowPotraitOff"];
    }
}


-(void) refreshViewForIPhoneCameraMode
{
    if(self.cameraModel.captureMode == DJIIPhone_PhotoModel){
        [_modeButton setStateIconNormal:@"handleCameraOff" iconSelected:@"handleCameraOn"];
    }else if(self.cameraModel.captureMode == DJIIPhone_VideoModel){
        [_modeButton setStateIconNormal:@"handle_mode_video_auto_off" iconSelected:@"handle_mode_video_auto_on"];
    }
}

-(void) restoreDefaultStatus
{
    if(self.modeButton.selected == YES){
        [self.modeButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonClick:(id)sender {
    [self reloadSkins];
    [self.cameraAction actionClick_CaptureButton_OSMOModeView:sender];
}



@end
