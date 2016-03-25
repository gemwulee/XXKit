//
//  DJICameraIPhoneHandler.m
//  Phantom3
//
//  Created by tomxiang on 3/24/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import "DJICameraIPhoneHandler.h"
#import "DJIIPhoneCameraView.h"
#import <AVFoundation/AVFoundation.h>

@interface DJICameraIPhoneHandler()
@property(nonatomic,weak) DJIIPhoneCameraView *cameraView;
@end


@implementation DJICameraIPhoneHandler

-(instancetype)initWithCameraView:(DJIIPhoneCameraView*) cameraView
{
    if(self = [super init]){
        self.cameraView = cameraView;
    }
    return self;
}

//打开相机
-(void) openCamera:(AVCaptureSession*) session
{
    if (session) {
        [session startRunning];
    }
}

//关闭相机
-(void) closeCamera:(AVCaptureSession*) session
{
    if (session) {
        [session stopRunning];
    }
}

@end
