//
//  DJIIPhoneCameraViewController.h
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreImage/CoreImage.h>
#import "DJIIPhoneCameraModel.h"

@interface DJIIPhoneCameraViewController : UIViewController


-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model;

//打开相机
-(void) openCamera;

//停止相机
-(void) closeCamera;

//拍照
-(void) takePhoto;

//切换摄像头
- (void)swapFrontAndBackCameras;

//开始录制视频
-(void) startRecordVideo;

//停止录制视频
-(void) stopRecordVideo;

-(void) reloadSkins;

-(NSArray*) getWhiteBalanceArea;

-(NSArray*) getISOArea;

-(NSArray*) getShutterArea;

@end
