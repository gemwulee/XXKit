//
//  OSMOCaptureToolView.m
//  Phantom3
//
//  Created by tomxiang on 16/3/25.
//  Copyright (c) 2016年 DJIDevelopers.com. All rights reserved.
//
//

#import "OSMOCaptureToolView.h"
#import "OSMOSwitchView.h"
#import "OSMOModeView.h"
#import "OSMOPhotoVideoView.h"
#import "OSMOPlayBackView.h"
#import "OSMOSwapCaptureView.h"
#import "XXBase.h"

@interface OSMOCaptureToolView()

@property(nonatomic,strong) OSMOSwitchView            *swtichView;
@property(nonatomic,strong) OSMOModeView              *modeView;
@property(nonatomic,strong) OSMOPhotoVideoView        *photoVideoButton;
@property(nonatomic,strong) OSMOPlayBackView          *playBackButton;
@property(nonatomic,strong) OSMOSwapCaptureView       *swapCaptureView;

@end


@implementation OSMOCaptureToolView

- (void)initData{}
- (void)initViews{
    
    _swtichView         = [[OSMOSwitchView alloc] initWithFrame:OSMO_ICON_FRAME withModel:self.cameraModel camera:self.cameraAction];
    _modeView           = [[OSMOModeView alloc] initWithFrame:OSMO_ICON_FRAME withModel:self.cameraModel camera:self.cameraAction];
    _photoVideoButton   = [[OSMOPhotoVideoView alloc] initWithFrame:OSMO_ICON_FRAME withModel:self.cameraModel camera:self.cameraAction];
    _playBackButton     = [[OSMOPlayBackView alloc] initWithFrame:OSMO_ICON_FRAME withModel:self.cameraModel camera:self.cameraAction];
    _swapCaptureView    = [[OSMOSwapCaptureView alloc] initWithFrame:OSMO_ICON_FRAME withModel:self.cameraModel camera:self.cameraAction];
    
    
    [self addSubview:_swtichView];
    [self addSubview:_modeView];
    [self addSubview:_photoVideoButton];
    [self addSubview:_swapCaptureView];
    [self addSubview:_playBackButton];
}
- (void)initEvent{}

- (void)layoutLandscape{
    _swtichView.origin         = CGPointMake(0, (self.height - OSMO_ICON_HEIGHT*5)/2);
    _modeView.origin           = CGPointMake(0,_swtichView.bottom);
    _photoVideoButton.origin   = CGPointMake(0,_modeView.bottom);
    _playBackButton.origin     = CGPointMake(0,_photoVideoButton.bottom);
    _swapCaptureView.origin    = CGPointMake(0,_playBackButton.bottom);
}

- (void)layoutPortrait{
    _swtichView.origin         = CGPointMake((self.width - OSMO_ICON_HEIGHT*5)/2,0);
    _modeView.origin           = CGPointMake(_swtichView.right, 0);
    _photoVideoButton.origin   = CGPointMake(_modeView.right, 0);
    _playBackButton.origin     = CGPointMake(_photoVideoButton.right, 0);
    _swapCaptureView.origin    = CGPointMake(_playBackButton.right, 0);
    
}
//根据mode刷状态
- (void)refreshViewForIPhoneCameraMode{
    [_modeView refreshViewForIPhoneCameraMode];
}
- (void)restoreDefaultStatus{
    [_modeView restoreDefaultStatus];
}
@end

