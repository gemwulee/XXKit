//
//  DJIIPhoneCameraModel.m
//  Phantom3
//
//  Created by tomxiang on 3/24/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import "DJIIPhoneCameraModel.h"

@implementation DJIIPhoneCameraModel

-(instancetype)init
{
    if (self = [super init]) {
        [self initDefaultConfig];
    }
    return self;
}

-(void) initDefaultConfig
{
    //拍照模式
    self.captureMode = DJIIPhone_PhotoModel;
    
    //后置摄像头
    self.devicePosition = DJIIPhone_DevicePositionBack;
    
    //双指倍数1.f
    self.doubleFingerZoom = 1.f;

    //自动模式
    self.autoManual = DJIIPhone_SettingAuto;
    
    //高分辨率
    self.resolution = DJIIPhone_AVCaptureSessionPresetHigh;
    
    //闪光灯默认关闭
    self.flashlight = NO;
}

@end
