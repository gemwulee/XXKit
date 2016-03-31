//
//  DJIIPhoneCameraView.h
//  Phantom3
//
//  Created by tomxiang on 3/24/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSMOView.h"

@class DJIIPhoneCameraModel;

@interface DJIIPhoneCameraView : OSMOView

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model;

//打开相机
-(void) openCamera;

//停止相机
-(void) closeCamera;

//旋转的时候调用回调
-(void) resetCameraFrame:(CGRect) bounds;

//拍照
-(void) takePhoto;

//切换摄像头
- (void)swapFrontAndBackCameras;

//开始录制视频
-(void) startRecordVideo;

//停止录制视频
-(void) stopRecordVideo;



@end
