//
//  DJICameraIPhoneHandler.h
//  Phantom3
//
//  Created by tomxiang on 3/24/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class DJIIPhoneCameraView;
@class AVCaptureSession;

@interface DJICameraIPhoneHandler : NSObject

-(instancetype)initWithCameraView:(DJIIPhoneCameraView*) cameraView;

//相机开关
-(void) openCamera:(AVCaptureSession*) session;
-(void) closeCamera:(AVCaptureSession*) session;

//摄像头
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position;
- (void) swapFrontAndBack:(AVCaptureSession*) session;

//拍照
- (void)takePhoto:(CIImage*) ciImage context:(CIContext*) context;

//获取旋转角度
-(CGAffineTransform) getCameraTransform;

//获取视频文件名
-(NSString*) getVideoFileName;
@end
