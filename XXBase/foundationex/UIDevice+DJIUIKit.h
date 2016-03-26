//
//  DJIDevice.h
//  Phantom3
//
//  Created by Jerome.zhang on 14-3-10.
//  Copyright (c) 2014年 Jerome.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_IPAD ([UIDevice currentScreen] == DJIDeviceScreenType1024x768)
#define IS_IPHONE4 ([UIDevice currentScreen] == DJIDeviceScreenType480x320)
#define IS_IPHONE5 ([UIDevice currentScreen] == DJIDeviceScreenType568x320)
#define IS_IPHONE6 ([UIDevice currentScreen] == DJIDeviceScreenType667x375)
#define IS_IPHONE6PLUS ([UIDevice currentScreen] == DJIDeviceScreenType736x414)

#define IS_M43CAMERA ([DJICameraLogic sharedInstance].isM43Camera)

typedef NS_ENUM(NSInteger, DJIDeviceScreenType) {
    DJIDeviceScreenTypeUnknown,     //未知设备
    DJIDeviceScreenType480x320,     //iphone3gs,iphone4s,iphone4
    DJIDeviceScreenType568x320,     //iphone5,iphone5s.
    DJIDeviceScreenType667x375,     //iphone6,
    DJIDeviceScreenType736x414,     //iphone6s
    DJIDeviceScreenType1024x768,    //ipad1,2,ipad mini,ipad3,4,air ,ipad mini retina.

};

typedef NS_ENUM(NSInteger, UIDeviceType){
    UIDeviceType_None,
    
    UIDeviceType_iPhone1G,
    UIDeviceType_iPhone3G,
    UIDeviceType_iPhone3GS,
    UIDeviceType_iPhone4,
    UIDeviceType_iPhone4S,
    UIDeviceType_iPhone5,
    UIDeviceType_iPhone5C,
    UIDeviceType_iPhone5S,
    UIDeviceType_iPhone6,
    UIDeviceType_iPhone6Plus,
    UIDeviceType_iPhone6s,
    UIDeviceType_iPhone6sPlus,
    
    UIDeviceType_iPodTouch1,
    UIDeviceType_iPodTouch2,
    UIDeviceType_iPodTouch3,
    UIDeviceType_iPodTouch4,
    UIDeviceType_iPodTouch5,
    
    UIDeviceType_iPad1,
    UIDeviceType_iPad2,
    UIDeviceType_iPad3,
    UIDeviceType_iPad4,
    UIDeviceType_iPadAir,
    UIDeviceType_iPadAir2,
    
    UIDeviceType_iPadMini,
    UIDeviceType_iPadMini2,
    UIDeviceType_iPadMini3,
    UIDeviceType_iPadMini4,
    
    UIDeviceType_Simulator,
    UIDeviceType_Unknown,
};

@interface UIDevice (DJIUIKit)

/**
 *  当前的版本
 *
 *  @return 返回当前的系统版本
 */
+ (float)currentVersion;

+ (NSString *)uniqueRunCode;

/**
 *  获取屏幕尺寸
 *
 *  @return 当前的屏幕尺寸
 */
+ (DJIDeviceScreenType)currentScreen;

/**
 *  是否横屏
 *
 *  @return
 */
+ (BOOL)isLandscape;

+ (NSString *)deviceString;

+ (UIDeviceType)deviceType;

@end
