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

-(void) actionClick_PlayBackButton_OSMOPlayBackView:(id) sender
{
    NSLog(@"actionClick_PlayBackButton_OSMOPlayBackView");

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
        [self.rootVC addChildViewController:menuVC];
        [self.rootVC.rightFirstMenuPlaceView addSubview:menuVC.view];
        
        [menuVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.rootVC.rightFirstMenuPlaceView);
            make.width.equalTo(self.rootVC.rightFirstMenuPlaceView);
            make.height.equalTo(self.rootVC.rightFirstMenuPlaceView);
        }];
    }else{
        for (UIView *view in self.rootVC.rightFirstMenuPlaceView.subviews) {
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
