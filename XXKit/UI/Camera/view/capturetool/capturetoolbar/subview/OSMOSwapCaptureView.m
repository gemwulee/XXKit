//
//  OSMOSwitchCaptureView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOSwapCaptureView.h"
#import "Masonry.h"
#import "DJIIPhoneCameraModel.h"
#import "OSMOCaptureToolView.h"

@interface OSMOSwapCaptureView()
@property(nonatomic,strong) UIButton    *buttonSwap;
@end

@implementation OSMOSwapCaptureView

-(void) initData
{}
-(void) initViews
{
    _buttonSwap = [[UIButton alloc] init];
    [self addSubview:_buttonSwap];
    _buttonSwap.backgroundColor = [UIColor clearColor];
    
    [_buttonSwap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(OSMO_ICON_WIDTH, OSMO_ICON_HEIGHT));
    }];
    
    _buttonSwap.userInteractionEnabled = YES;

    [_buttonSwap addTarget:self action:@selector(swapFrontAndBackCameras) forControlEvents:UIControlEventTouchUpInside];
    [_buttonSwap setImage:[UIImage imageNamed:@"captureTool_switch_off"] forState:UIControlStateNormal];
    [_buttonSwap setImage:[UIImage imageNamed:@"captureTool_switch_on"] forState:UIControlStateHighlighted];

    [self reloadSkins];
}

-(void) initEvent
{}
-(void) layoutLandscape
{}
-(void) layoutPortrait
{}
//根据mode刷状态
-(void) refreshViewForIPhoneCameraMode
{}
//恢复默认态
-(void) restoreDefaultStatus
{}

-(void) swapFrontAndBackCameras
{
    if (self.cameraModel.devicePosition == DJIIPhone_DevicePositionFront) {
        self.cameraModel.devicePosition = DJIIPhone_DevicePositionBack;
    }else{
        self.cameraModel.devicePosition = DJIIPhone_DevicePositionFront;
    }
}

//- (void)buttonClick:(UIButton *)button {
//    button.selected = !button.selected;
//    [self reloadSkins];
//    
//    if(self.camera){}
//}

@end
