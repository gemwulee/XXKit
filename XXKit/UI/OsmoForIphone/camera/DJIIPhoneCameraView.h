//
//  DJIIPhoneCameraView.h
//  Phantom3
//
//  Created by tomxiang on 3/24/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DJIIPhoneCameraModel;

@interface DJIIPhoneCameraView : UIView

-(instancetype) initWithFrame:(CGRect) frame cameraModel:(DJIIPhoneCameraModel*) iPhoneCamera;

//打开相机
-(void) openCamera;

//停止相机
-(void) closeCamera;

//旋转的时候调用回调
-(void) resetCameraFrame:(CGRect) bounds;

@end
