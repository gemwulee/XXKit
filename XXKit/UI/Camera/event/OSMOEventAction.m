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

@interface OSMOEventAction()
@property(nonatomic,weak) DJIIPhoneCameraModel  *cameraModel;
@property(nonatomic,weak) DJIIPhoneCameraViewController   *camera;
@end

@implementation OSMOEventAction

-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model camera:(DJIIPhoneCameraViewController*) camera
{
    if(self = [super init]){
        self.cameraModel = model;
        self.camera = camera;
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

-(void) actionClick_PlayBackButton_OSMOPlayBackView
{
    NSLog(@"actionClick_PlayBackButton_OSMOPlayBackView");

}

#pragma mark- right tool
-(void) actionClick_HomeButton_OSMORightSettingView
{
    NSLog(@"actionClick_HomeButton_OSMORightSettingView");
}

-(void) actionClick_CameraButton_OSMORightSettingView
{
    NSLog(@"actionClick_CameraButton_OSMORightSettingView");

}

-(void) actionClick_GimbalButton_OSMORightSettingView
{
    NSLog(@"actionClick_GimbalButton_OSMORightSettingView");

}

-(void) actionClick_SettingButton_OSMORightSettingView
{
    NSLog(@"actionClick_SettingButton_OSMORightSettingView");

}
@end
