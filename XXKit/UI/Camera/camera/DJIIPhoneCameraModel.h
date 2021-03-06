//
//  DJIIPhoneCameraModel.h
//  Phantom3
//
//  Created by tomxiang on 3/24/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "DJIIPhoneConfig.h"

@interface DJIIPhoneCameraModel : NSObject

//是否可用
@property(nonatomic,assign,readwrite) DJIIPhone_ConnectStatus connectStatus;
//相机拍照或者摄影模式
@property(nonatomic,assign,readwrite) DJIIPhoneCameraMode captureMode;
//摄影状态
@property(nonatomic,assign,readwrite) DJIIPhoneVideoRecordState videoState;
//摄像头方向，默认后置
@property(nonatomic,assign,readwrite) DJIIPhoneCameraPosition devicePosition;

//快门
@property(nonatomic,assign,readwrite) CGFloat shutterValue;
//ISO
@property(nonatomic,assign,readwrite) CGFloat ISOValue;
//双指变焦倍数
@property(nonatomic,assign,readwrite) CGFloat doubleFingerZoom;
//对焦是否自动
@property(nonatomic,assign,readwrite) AVCaptureFocusMode avFocusMode;
//手动模式还是自动模式
@property(nonatomic,assign,readwrite) DJIIPhoneSettingAutoManual autoManual;
//视频分辨率
@property(nonatomic,assign,readwrite) DJIIPhoneResulotion resolution;
//白平衡
@property(nonatomic,assign,readwrite) DJIIPhoneWhiteBalanceStyle balanceWhiteBalanceMode;
//闪光灯
@property(nonatomic,assign,readwrite) BOOL flashlight;
//情景模式
@property(nonatomic,assign,readwrite) DJIIPhoneContextualMode contextualMode;
//网格
@property(nonatomic,assign,readwrite) DJIIPhoneGridStyle gridStyle;

//----------------照相机--------------
//拍摄模式
@property(nonatomic,assign,readwrite) DJIIPhonePhotoMode photoMode;
//单拍的具体模式
@property(nonatomic,assign,readwrite) DJIIPhonePhotoSingleModeDetail photoSingleModeDetail;
//全景的具体模式
@property(nonatomic,assign,readwrite )DJIIPhone_PhotoPanoModeDetail photoPanoModeDetail;

//----------------摄影机---------------
//摄影模式
@property(nonatomic,assign,readwrite) DJIIPhoneVideoMode videoMode;
//延时摄影
@property(nonatomic,assign,readwrite) CGFloat delayShootTime;



@end
