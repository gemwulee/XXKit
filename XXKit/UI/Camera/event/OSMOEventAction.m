//
//  OSMOEventAction.m
//  XXKit
//
//  Created by tomxiang on 3/30/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOEventAction.h"
#import "DJIIPhoneCameraModel.h"
#import "DJIIPhoneCameraViewController.h"
#import "OSMOIPhoneViewController.h"
#import "OSMOMenuController.h"
#import "OSMOMenuPlaceView.H"
#import "Masonry.h"
#import "OSMOToolViewController.h"
#import "OSMOCapturePhotoModeView.h"
#import "OSMOCaptureVideoModeView.h"
#import "OSMOCaptureModeSelectView.h"
#import "OSMOVerticalPickerView.h"
#import "XXBase.h"
#import "OSMOManualmodeView.h"
#import "OSMOTableObject.h"
#import "OSMORightSettingView.h"
#import "OSMOStatusObserveManager.h"

@interface OSMOEventAction()

@property(nonatomic,weak) DJIIPhoneCameraModel            *cameraModel;
@property(nonatomic,weak) DJIIPhoneCameraViewController   *camera;
@property(nonatomic,weak) OSMOIPhoneViewController        *rootVC;

@end

@implementation OSMOEventAction

-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model camera:(DJIIPhoneCameraViewController*) camera rootVC:(OSMOIPhoneViewController*) rootVC
{
    if(self = [super init]){
        self.cameraModel = model;
        self.camera      = camera;
        self.rootVC      = rootVC;
    }
    return self;
}

#pragma mark- capture tool
-(void) actionClick_PhotoButton_OSMOPhotoVideoView
{
    [self.camera takePhoto];
}

-(void) actionClick_VideoButton_OSMOPhotoVideoView
{
    switch(self.cameraModel.videoState){
            
        case DJIIPhone_VideoRecordState_Stop:
        {
            self.cameraModel.videoState = DJIIPhone_VideoRecordState_ING;
            
            if(self.camera){
                [self.camera startRecordVideo];
            }
        }
            break;
        case DJIIPhone_VideoRecordState_ING:
        {
            self.cameraModel.videoState = DJIIPhone_VideoRecordState_Stop;
            
            if(self.camera){
                [self.camera stopRecordVideo];
            }
        }
            break;
    }
}

-(void) actionClick_CaptureButton_OSMOModeView:(id) sender
{
    UIButton *button = (UIButton*) sender;
    if (button.selected) {
        self.rootVC.observeManager.managerStateLeft = OSMOViewManagerState_LEFT_FIRST_OPEN;

    }else{
        self.rootVC.observeManager.managerStateLeft = OSMOViewManagerState_LEFT_FIRST_CLOSE;
    }
}

-(void) actionClick_PlayBackButton_OSMOPlayBackView
{
    NSLog(@"%s",__FUNCTION__);
}


#pragma mark- capture left first photo
-(NSString*) _getPlistConfig
{
    NSString *plist = nil;
    if(self.cameraModel.captureMode == DJIIPhone_PhotoModel){
        switch (self.cameraModel.photoMode ) {
            case DJIIPhone_PhotoSingleMode:{
                plist = photoSingleModeSetting_PLIST;
            }
                break;
            case DJIIPhone_PhotoPanoMode:{
                plist = photoPanoModeSetting_PLIST;
            }
                break;
            default:{
                assert(0);
                break;
            }
        }
    }
    else{
        assert(0);
    }
    return plist;
}

-(void) showSecondView:(id) sender
{
    NSString *plist = [self _getPlistConfig];
    UIButton *button = (UIButton*) sender;
    [self.rootVC.toolVC.leftSecondMenuPlaceView removeOSMOSubViews];

    if (button.selected) {
        OSMOCaptureModeSelectView *modeVC = [[OSMOCaptureModeSelectView alloc] initWithFrame:self.rootVC.toolVC.leftSecondMenuPlaceView.bounds withModel:_cameraModel camera:self plist:plist];
        [self.rootVC.toolVC.leftSecondMenuPlaceView addSubview:modeVC];
    }
}
- (void)actionClick_SingleButton_PhotoModeView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
    self.cameraModel.photoMode = DJIIPhone_PhotoSingleMode;
    [self showSecondView:sender];
    [self.rootVC.toolVC.leftFirstMenuPlaceView reloadSkins];
}
- (void)actionClick_MultipleButton_PhotoModeView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
    self.cameraModel.photoMode = DJIIPhone_PhotoContinuousMode;
    [self showSecondView:sender];

    [self.rootVC.toolVC.leftFirstMenuPlaceView reloadSkins];
}
- (void)actionClick_PanoButton_PhotoModeView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
    self.cameraModel.photoMode = DJIIPhone_PhotoPanoMode;
    [self showSecondView:sender];

    [self.rootVC.toolVC.leftFirstMenuPlaceView reloadSkins];
}
- (void)actionClick_IntervalButton_PhotoModeView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
    self.cameraModel.photoMode = DJIIPhone_PhotoIntervalMode;
    [self showSecondView:sender];

    [self.rootVC.toolVC.leftFirstMenuPlaceView reloadSkins];
}

#pragma mark- capture left first video
- (void)actionClick_VideoNormalButton_VideoModeView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
    self.cameraModel.videoMode = DJIIPhone_VideoAutoMode;
    [self.rootVC.toolVC.leftFirstMenuPlaceView reloadSkins];
}

- (void)actionClick_VideoHDButton_VideoModeView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
    self.cameraModel.videoMode = DJIIPhone_4KVideoMode;
    [self.rootVC.toolVC.leftFirstMenuPlaceView reloadSkins];
}

- (void)actionClick_VideoSlowButton_VideoModeView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
    self.cameraModel.videoMode = DJIIPhone_SlowVideoMode;
    [self.rootVC.toolVC.leftFirstMenuPlaceView reloadSkins];
}
- (void)actionClick_VideoDelayButton_VideoModeView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
    self.cameraModel.videoMode = DJIIPhone_DelayVideoMode;
    [self.rootVC.toolVC.leftFirstMenuPlaceView reloadSkins];
}

#pragma mark- right tool
-(void) actionClick_HomeButton_OSMORightSettingView:(id) sender
{
    [self.camera dismissViewControllerAnimated:NO completion:nil];
}

-(void) actionClick_CameraButton_OSMORightSettingView:(id) sender
{
    UIButton *button = (UIButton*) sender;
    if (button.selected) {
        self.rootVC.observeManager.managerStateRight = OSMOViewManagerState_RIGHT_FIRST_OPEN;
    }else{

        self.rootVC.observeManager.managerStateRight = OSMOViewManagerState_RIGHT_FIRST_CLOSE;
    }
}

-(void) actionClick_GimbalButton_OSMORightSettingView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
}

-(void) actionClick_SettingButton_OSMORightSettingView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark- right left first
//- (void) onSwitchChanged:(OSMOTableObject*)object status:(BOOL)isOn
//{
//    if (object && [object.titleL isEqualToString:@"mc_enterTravelMode_manual"]) {
//        if (isOn) {
//            self.cameraModel.autoManual = DJIIPhone_SettingManual;
//
//            [self _showTopManualPlaceView];
//            OSMOManualmodeView *manualModeView = [[OSMOManualmodeView alloc] initWithFrame:CGRectZero withModel:_cameraModel camera:self];
//            [self.rootVC.toolVC.topManualPlaceView addSubview:manualModeView];
//            
//            [manualModeView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.equalTo(self.rootVC.toolVC.topManualPlaceView);
//                make.width.equalTo(self.rootVC.toolVC.topManualPlaceView);
//                make.height.equalTo(self.rootVC.toolVC.topManualPlaceView);
//            }];
//            
//            [self.rootVC.toolVC.rightSettingPlaceView restoreDefaultStatus];
//            
//        }else{
//            self.cameraModel.autoManual = DJIIPhone_SettingAuto;
//
//            for (UIView *view in self.rootVC.toolVC.topManualPlaceView.subviews) {
//                [view removeFromSuperview];
//            }
//            [self _hiddenTopManualPlaceView];
//            
//        }
//    }
//}

#pragma mark- manualMode tool
-(void) actionClick_ISO_OSMOManualmodeView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
    [self _showPickerView:[_camera getISOArea]];
}

-(void) actionClick_Shutter_OSMOManualmodeView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
    [self _showPickerView:nil];
}

-(void) actionClick_WhiteBalance_OSMOManualmodeView:(id) sender
{
    NSLog(@"%s",__FUNCTION__);
    [self _showPickerView:nil];
}


#pragma mark- 内部方法
-(void) _showPickerView:(NSArray*) arrayDatasouce{
    self.rootVC.toolVC.topFirstPickerPlaceView.hidden = !self.rootVC.toolVC.topFirstPickerPlaceView.hidden;
    
    if(self.rootVC.toolVC.topFirstPickerPlaceView.hidden == NO){
        OSMOVerticalPickerView *verticalView = [[OSMOVerticalPickerView alloc] initWithFrame:CGRectZero withModel:_cameraModel camera:self];
        [verticalView setDataSourceArray:arrayDatasouce];
        [self.rootVC.toolVC.topFirstPickerPlaceView addSubview:verticalView];

        [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.rootVC.toolVC.topFirstPickerPlaceView);
        }];
    }else{
        [self.rootVC.toolVC.topFirstPickerPlaceView removeOSMOSubViews];
    }
}


@end
