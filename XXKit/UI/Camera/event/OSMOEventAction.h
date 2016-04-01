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

- (void)actionClick_PlayBackButton_OSMOPlayBackView;


#pragma mark- right tool
- (void)actionClick_HomeButton_OSMORightSettingView;

- (void)actionClick_CameraButton_OSMORightSettingView;

- (void)actionClick_GimbalButton_OSMORightSettingView;

- (void)actionClick_SettingButton_OSMORightSettingView;

@end
