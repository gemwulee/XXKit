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
        _managerState = OSMOViewManagerState_None;
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
    [self addObserver:self forKeyPath:@"self.managerState" options:0 context:nil];
}

-(void) removeKVOModel
{
    [self removeObserver:self forKeyPath:@"model.captureMode"];
    [self removeObserver:self forKeyPath:@"model.devicePosition"];
    [self removeObserver:self forKeyPath:@"model.videoState"];
    [self removeObserver:self forKeyPath:@"model.autoManual"];
    [self removeObserver:self forKeyPath:@"self.managerState"];

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
    }else if([keyPath isEqualToString:@"self.managerState"]){
        [self dealViewManagerStateLogic];
    }
}

-(void) dealOSMOManualmodeView
{
    if(self.model.autoManual == DJIIPhone_SettingManual){
        [self.cameraAction addOSMOManualmodeView];
        self.managerState = OSMOViewManagerState_TOP_FIRST_OPEN;
    }else{
        self.managerState = OSMOViewManagerState_RIGHT_FIRST_CLOSE;
    }
}

//仅仅处理互斥逻辑
-(void) dealViewManagerStateLogic
{
    switch (_managerState) {
        case OSMOViewManagerState_TOP_FIRST_OPEN: //当顶部出现的时候，左右都必须关闭
        {
            _rootCameraVC.toolVC.topManualPlaceView.hidden = NO;
            [self.rootCameraVC.toolVC.rightSettingPlaceView restoreDefaultStatus];
            [self.rootCameraVC.toolVC.captureToolPlaceView restoreDefaultStatus];
        }
            break;
            
        default:
        {
            [_rootCameraVC.toolVC.topManualPlaceView removeOSMOSubViews];
            _rootCameraVC.toolVC.topManualPlaceView.hidden = YES;
        }
            break;
    }
}


@end
