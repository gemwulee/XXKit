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
#import "OSMORightFirstMenuPlaceView.h"
#import "Masonry.h"
#import "OSMOToolViewController.h"
#import "OSMOCapturePhotoModeView.h"
#import "OSMOLeftFirstMenuPlaceView.h"
#import "OSMOCaptureVideoModeView.h"
#import "OSMOLeftSecondMenuPlaceView.h"
#import "OSMOCaptureModeSelectView.h"

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
    [self.rootVC.toolVC.leftFirstMenuPlaceView removeSubViews];
    [self.rootVC.toolVC.leftSecondMenuPlaceView removeSubViews];
    
    UIButton *button = (UIButton*) sender;
    
    if (button.selected) {
        
        if(self.cameraModel.captureMode == DJIIPhone_PhotoModel){
            OSMOCapturePhotoModeView *photoView = [[OSMOCapturePhotoModeView alloc] initWithFrame:self.rootVC.toolVC.leftFirstMenuPlaceView.bounds withModel:_cameraModel camera:self];
            [self.rootVC.toolVC.leftFirstMenuPlaceView addSubview:photoView];
            
            
        }else if(self.cameraModel.captureMode == DJIIPhone_VideoModel){
            
            OSMOCaptureVideoModeView *videoView = [[OSMOCaptureVideoModeView alloc] initWithFrame:self.rootVC.toolVC.leftFirstMenuPlaceView.bounds withModel:_cameraModel camera:self];
            [self.rootVC.toolVC.leftFirstMenuPlaceView addSubview:videoView];
        }
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
    [self.rootVC.toolVC.leftSecondMenuPlaceView removeSubViews];

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
        OSMOMenuController *menuVC = [[OSMOMenuController alloc] initWithPlistKey:MENU_CAMERA_SETTING];
        UINavigationController *osmoNav = [[UINavigationController alloc] initWithRootViewController:menuVC];
        
        [self.rootVC.toolVC addChildViewController:osmoNav];
        [self.rootVC.toolVC.rightFirstMenuPlaceView addSubview:osmoNav.view];
        
        [osmoNav.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.rootVC.toolVC.rightFirstMenuPlaceView);
            make.width.equalTo(self.rootVC.toolVC.rightFirstMenuPlaceView);
            make.height.equalTo(self.rootVC.toolVC.rightFirstMenuPlaceView);
        }];
    }else{
        for (UIView *view in self.rootVC.toolVC.rightFirstMenuPlaceView.subviews) {
            [view removeFromSuperview];
        }
    }
 
}

-(void) actionClick_GimbalButton_OSMORightSettingView:(id) sender
{
    NSLog(@"actionClick_GimbalButton_OSMORightSettingView");

}

-(void) actionClick_SettingButton_OSMORightSettingView:(id) sender
{
    NSLog(@"actionClick_SettingButton_OSMORightSettingView");

}
@end
