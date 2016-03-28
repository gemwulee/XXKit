//
//  DJIIPhoneConfig.h
//  Phantom3
//
//  Created by tomxiang on 3/25/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#ifndef DJIIPhoneConfig_h
#define DJIIPhoneConfig_h



//拍照还是摄影
typedef NS_ENUM(NSUInteger, DJIIPhoneCameraMode){
    DJIIPhone_PhotoModel = 0,                //拍照
    DJIIPhone_VideoModel                     //摄影
};

//拍照模式
typedef NS_ENUM(NSUInteger, DJIIPhonePhotoMode) {
    DJIIPhone_PhotoSingleMode =  0,          //单拍
    DJIIPhone_PhotoContinuousMode,           //连拍
    DJIIPhone_PhotoOverAllMode,              //全景
    DJIIPhone_PhotoTimeVideoMode,            //延时
};

//摄影模式
typedef NS_ENUM(NSUInteger, DJIIPhoneVideoMode) {
    DJIIPhone_VideoAutoMode =  0,            //自动录像
    DJIIPhone_4KVideoMode,                   //4k录像
    DJIIPhone_SlowVideoMode,                 //慢动作
    DJIIPhone_DelayVideoMode                 //延时摄影
} ;

//摄像头方向
typedef NS_ENUM(NSUInteger, DJIIPhoneCameraPosition) {
    DJIIPhone_DevicePositionFront = 0,       //前置摄像头
    DJIIPhone_DevicePositionBack,            //后置摄像头
};

//相机手动还是自动模式
typedef NS_ENUM(NSUInteger, DJIIPhoneSettingAutoManual) {
    DJIIPhone_SettingAuto = 0,               //自动模式
    DJIIPhone_SettingManual,                 //手动模式
};

//云台情景模式
typedef NS_ENUM(NSUInteger, DJIIPhoneContextualMode){
    DJIIPhone_NoneMode  =  0,                //无
    DJIIPhone_SportMode,                     //运动模式
    DJIIPhone_SceneryVideoMode,              //景物模式
    DJIIPhone_CustomMode,                    //自定义模式
};

//网格模式
typedef NS_ENUM(NSUInteger, DJIIPhoneGridStyle) {
    DJIIPhone_GridNoneStyle =  0,            //无
    DJIIPhone_GridCircleDiagonalStyle,       //网格＋对角线
    DJIIPhone_SquareStyle,                   //方格
    DJIIPhon_eCenterPointStyle               //中心点
};

//滤镜模式
typedef NS_ENUM(NSUInteger,DJIIPhoneFilterStyle) {
    DJIIPhoneFilterNoneStyle = 0,            //无
    DJIIPhoneFilterPeopleStyle,              //人像
    DJIIPhoneFilterSceneryStyle              //风景
} ;

//分辨率
typedef NS_ENUM(NSUInteger,DJIIPhoneResulotion){
    DJIIPhone_AVCaptureSessionPresetPhoto = 0,
    DJIIPhone_AVCaptureSessionPresetHigh,
    DJIIPhone_AVCaptureSessionPresetMedium,
    DJIIPhone_AVCaptureSessionPresetLow,
    DJIIPhone_AVCaptureSessionPreset352x288,
    DJIIPhone_AVCaptureSessionPreset640x480,
    DJIIPhone_AVCaptureSessionPreset1280x720,
    DJIIPhone_AVCaptureSessionPreset1920x1080,
    DJIIPhone_AVCaptureSessionPresetiFrame960x540,
    DJIIPhone_AVCaptureSessionPresetiFrame1280x720,
    DJIIPhone_AVCaptureSessionPresetInputPriority
};



#endif /* DJIIPhoneConfig_h */
