//
//  OSMOEventAction.h
//  XXKit
//
//  Created by tomxiang on 3/30/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DJIIPhoneCameraViewController;
@class DJIIPhoneCameraModel;
@class OSMOIPhoneViewController;

@interface OSMOEventAction : NSObject

-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model camera:(DJIIPhoneCameraViewController*) camera rootVC:(OSMOIPhoneViewController*) rootVC;


#pragma mark- capture tool
- (void)actionClick_PhotoButton_OSMOPhotoVideoView;
- (void)actionClick_VideoButton_OSMOPhotoVideoView;
-(void) actionClick_CaptureButton_OSMOModeView:(id) sender;
- (void)actionClick_PlayBackButton_OSMOPlayBackView;

#pragma mark- capture left first
- (void)actionClick_SingleButton_PhotoModeView:(id) sender;
- (void)actionClick_MultipleButton_PhotoModeView:(id) sender;
- (void)actionClick_PanoButton_PhotoModeView:(id) sender;
- (void)actionClick_IntervalButton_PhotoModeView:(id) sender;

- (void)actionClick_VideoNormalButton_VideoModeView:(id) sender;
- (void)actionClick_VideoHDButton_VideoModeView:(id) sender;
- (void)actionClick_VideoSlowButton_VideoModeView:(id) sender;
- (void)actionClick_VideoDelayButton_VideoModeView:(id) sender;

#pragma mark- right tool
- (void)actionClick_HomeButton_OSMORightSettingView:(id) sender;
- (void)actionClick_CameraButton_OSMORightSettingView:(id) sender;
- (void)actionClick_GimbalButton_OSMORightSettingView:(id) sender;
- (void)actionClick_SettingButton_OSMORightSettingView:(id) sender;


#pragma mark- manualMode tool
- (void)actionClick_ISO_OSMOManualmodeView:(id) sender;
- (void)actionClick_Shutter_OSMOManualmodeView:(id) sender;
- (void)actionClick_WhiteBalance_OSMOManualmodeView:(id) sender;

@end
