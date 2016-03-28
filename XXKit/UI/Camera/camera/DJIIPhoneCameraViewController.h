//
//  DJIIPhoneCameraViewController.h
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DJIIPhoneCameraModel;

@interface DJIIPhoneCameraViewController : NSObject

-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model;

//加载view
-(void) layoutInView:(UIView*) view;

//打开相机
-(void) openCamera;

//停止相机
-(void) closeCamera;

//旋转的时候调用回调
-(void) resetCameraFrame:(CGRect) bounds;

//拍照
-(void) takePhoto:(id) sender;

//回放
-(void) buttonPlayBack:(id) sender;

@end
