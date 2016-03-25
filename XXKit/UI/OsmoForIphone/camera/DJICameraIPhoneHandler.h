//
//  DJICameraIPhoneHandler.h
//  Phantom3
//
//  Created by tomxiang on 3/24/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DJIIPhoneCameraView;
@class AVCaptureSession;

@interface DJICameraIPhoneHandler : NSObject

-(instancetype)initWithCameraView:(DJIIPhoneCameraView*) cameraView;

//相机开关
-(void) openCamera:(AVCaptureSession*) session;
-(void) closeCamera:(AVCaptureSession*) session;


@end
