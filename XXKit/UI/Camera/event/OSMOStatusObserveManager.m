//
//  OSMOStatusObserveManager.m
//  XXKit
//
//  Created by tomxiang on 4/8/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOStatusObserveManager.h"
#import "OSMOToolViewController.h"
#import "DJIIPhoneCameraModel.h"
#import "DJIIPhoneCameraViewController.h"
#import "OSMOIPhoneViewController.h"
#import "OSMOCaptureToolView.h"
#import "OSMOMenuPlaceView.h"
#import "OSMOManualmodeView.h"
#import "Masonry.h"
#import "OSMORightSettingView.h"
#import "OSMOCapturePhotoModeView.h"
#import "OSMOCaptureVideoModeView.h"
#import "OSMOMenuController.h"

@interface OSMOStatusObserveManager()
@property(nonatomic,weak)   DJIIPhoneCameraModel          *model;
@property(nonatomic,weak)   OSMOIPhoneViewController      *rootCameraVC;
@property(nonatomic,weak)   DJIIPhoneCameraViewController *camera;
@property(nonatomic,weak)   OSMOEventAction               *cameraAction;
@end

@implementation OSMOStatusObserveManager

-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model
                      camera:(DJIIPhoneCameraViewController*) camera
                      rootVC:(OSMOIPhoneViewController*) rootVC
                      camera:(OSMOEventAction*) cameraAction
{
    if (self = [super init]) {
        _managerStateLeft  = OSMOViewManagerState_LEFT_FIRST_CLOSE;
        _managerStateRight = OSMOViewManagerState_RIGHT_FIRST_CLOSE;
        _managerStateTop   = OSMOViewManagerState_TOP_FIRST_CLOSE;

        _model  = model;
        _rootCameraVC = rootVC;
        _camera       = camera;
        _cameraAction = cameraAction;
        
        [self addKVOModel];
    }
    return self;
}
-(void)dealloc
{
    [self removeKVOModel];
}
#pragma mark- 增加观察者
-(void) addKVOModel
{
    [self addObserver:self forKeyPath:@"model.captureMode" options:0 context:nil];
    [self addObserver:self forKeyPath:@"model.devicePosition" options:0 context:nil];
    [self addObserver:self forKeyPath:@"model.videoState" options:0 context:nil];
    [self addObserver:self forKeyPath:@"model.autoManual" options:0 context:nil];
    [self addObserver:self forKeyPath:@"self.managerStateLeft" options:0 context:nil];
    [self addObserver:self forKeyPath:@"self.managerStateRight" options:0 context:nil];
    [self addObserver:self forKeyPath:@"self.managerStateTop" options:0 context:nil];

}

-(void) removeKVOModel
{
    [self removeObserver:self forKeyPath:@"model.captureMode"];
    [self removeObserver:self forKeyPath:@"model.devicePosition"];
    [self removeObserver:self forKeyPath:@"model.videoState"];
    [self removeObserver:self forKeyPath:@"model.autoManual"];
    [self removeObserver:self forKeyPath:@"self.managerStateLeft"];
    [self removeObserver:self forKeyPath:@"self.managerStateRight"];
    [self removeObserver:self forKeyPath:@"self.managerStateTop"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"model.captureMode"] || [keyPath isEqualToString:@"model.videoState"]) {
        if(_rootCameraVC.toolVC.captureToolPlaceView){
            [_rootCameraVC.toolVC.captureToolPlaceView reloadSkins];
            [_rootCameraVC.toolVC.captureToolPlaceView restoreDefaultStatus];
            [_camera reloadSkins];
        }
    }
    else if([keyPath isEqualToString:@"model.devicePosition"]){
        [_camera swapFrontAndBackCameras];
    }
    else if([keyPath isEqualToString:@"model.autoManual"]){
        [self dealOSMOManualmodeView];
    }else if([keyPath isEqualToString:@"self.managerStateLeft"]){
        [self dealViewManagerStateLogicLeft];
        
    }else if([keyPath isEqualToString:@"self.managerStateRight"]){
        [self dealViewManagerStateLogicRight];
        
    }else if([keyPath isEqualToString:@"self.managerStateTop"]){
        [self dealViewManagerStateLogicTop];
    }
}

-(void) dealOSMOManualmodeView
{
    if(self.model.autoManual == DJIIPhone_SettingManual){
        [self addOSMOManualmodeView];
        //如果是手动挡，左右侧必须关闭,否则会有遮挡
        self.managerStateTop = OSMOViewManagerState_TOP_FIRST_OPEN;
        self.managerStateRight = OSMOViewManagerState_RIGHT_FIRST_CLOSE;
        self.managerStateLeft = OSMOViewManagerState_RIGHT_FIRST_CLOSE;
    }else{
        //如果是自动挡，关闭top即可，其他沿用以前的策略
        self.managerStateTop = OSMOViewManagerState_TOP_FIRST_CLOSE;
    }
}

//仅仅处理互斥逻辑
#pragma mark- TopView Open/Close
-(void) dealViewManagerStateLogicTop
{
    switch(self.managerStateTop){
        case OSMOViewManagerState_TOP_FIRST_OPEN:{
            [self _showTopView];
        }
            break;
        case OSMOViewManagerState_TOP_FIRST_CLOSE:{
            [self _closeTopView];
        }
            break;
    };
}

-(void) _showTopView
{
    _rootCameraVC.toolVC.topManualPlaceView.hidden = NO;
    [self.rootCameraVC.toolVC.rightSettingPlaceView restoreDefaultStatus];
    [self.rootCameraVC.toolVC.captureToolPlaceView restoreDefaultStatus];
    [self addOSMOManualmodeView];
}

-(void) addOSMOManualmodeView
{
    OSMOManualmodeView *manualModeView = [[OSMOManualmodeView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    [self.rootCameraVC.toolVC.topManualPlaceView addSubview:manualModeView];
    [manualModeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.rootCameraVC.toolVC.topManualPlaceView);
    }];
    
}

-(void) _closeTopView
{
    [_rootCameraVC.toolVC.topManualPlaceView removeOSMOSubViews];
    _rootCameraVC.toolVC.topManualPlaceView.hidden = YES;
}

#pragma mark- LeftView Open/Close
-(void) dealViewManagerStateLogicLeft
{
    switch(self.managerStateLeft){
        case OSMOViewManagerState_LEFT_FIRST_OPEN:{
            self.managerStateTop = OSMOViewManagerState_TOP_FIRST_CLOSE;
            [self _showLeftView];
        }
            break;
        case OSMOViewManagerState_LEFT_FIRST_CLOSE:{
            if(self.model.autoManual == DJIIPhone_SettingManual && self.managerStateRight == OSMOViewManagerState_RIGHT_FIRST_CLOSE){
                self.managerStateTop = OSMOViewManagerState_TOP_FIRST_OPEN;
            }
            [self _closeLeftView];
        }
            break;
    };
}


-(void) _showLeftView
{
    self.managerStateTop = OSMOViewManagerState_TOP_FIRST_CLOSE;

    [self.rootCameraVC.toolVC.leftFirstMenuPlaceView removeOSMOSubViews];
    [self.rootCameraVC.toolVC.leftSecondMenuPlaceView removeOSMOSubViews];
    
    if(self.model.captureMode == DJIIPhone_PhotoModel){
        OSMOCapturePhotoModeView *photoView = [[OSMOCapturePhotoModeView alloc] initWithFrame:self.rootCameraVC.toolVC.leftFirstMenuPlaceView.bounds withModel:_model camera:_cameraAction];
        [self.rootCameraVC.toolVC.leftFirstMenuPlaceView addSubview:photoView];
        
    }else if(self.model.captureMode == DJIIPhone_VideoModel){
        
        OSMOCaptureVideoModeView *videoView = [[OSMOCaptureVideoModeView alloc] initWithFrame:self.rootCameraVC.toolVC.leftFirstMenuPlaceView.bounds withModel:_model camera:_cameraAction];
        [self.rootCameraVC.toolVC.leftFirstMenuPlaceView addSubview:videoView];
    }
}

-(void) _closeLeftView
{
    [self.rootCameraVC.toolVC.leftFirstMenuPlaceView removeOSMOSubViews];
    [self.rootCameraVC.toolVC.leftSecondMenuPlaceView removeOSMOSubViews];
    [self.rootCameraVC.toolVC.captureToolPlaceView restoreDefaultStatus];
}

#pragma mark- TopView Open/Close
-(void) dealViewManagerStateLogicRight
{
    switch(self.managerStateRight){
        case OSMOViewManagerState_RIGHT_FIRST_OPEN:{
            self.managerStateTop = OSMOViewManagerState_TOP_FIRST_CLOSE;
            [self _showRightView];
        }
            break;
        case OSMOViewManagerState_RIGHT_FIRST_CLOSE:{
            if(self.model.autoManual == DJIIPhone_SettingManual && self.managerStateLeft == OSMOViewManagerState_LEFT_FIRST_CLOSE){
                self.managerStateTop = OSMOViewManagerState_TOP_FIRST_OPEN;
            }
            [self _closeRightView];
        }
            break;
    };
}

-(void) _showRightView
{
    OSMOMenuController *menuVC = [[OSMOMenuController alloc] initWithPlistKey:MENU_CAMERA_SETTING withModel:self.model camera:self.cameraAction];
    UINavigationController *osmoNav = [[UINavigationController alloc] initWithRootViewController:menuVC];
    
    [self.rootCameraVC.toolVC addChildViewController:osmoNav];
    [self.rootCameraVC.toolVC.rightFirstMenuPlaceView addSubview:osmoNav.view];
    
    [osmoNav.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.rootCameraVC.toolVC.rightFirstMenuPlaceView);
    }];
}

-(void) _closeRightView
{
    for (UIView *view in self.rootCameraVC.toolVC.rightFirstMenuPlaceView.subviews) {
        [view removeFromSuperview];
    }
    [self.rootCameraVC.toolVC.rightSettingPlaceView restoreDefaultStatus];
}


@end
