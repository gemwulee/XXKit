//
//  DJIDevice.m
//  Phantom3
//
//  Created by Jerome.zhang on 14-3-10.
//  Copyright (c) 2014年 Jerome.zhang. All rights reserved.
//

#import "UIDevice+DJIUIKit.h"
#import "sys/utsname.h"

@implementation UIDevice(DJIUIKit)

+ (float)currentVersion{
    static float version = -1.0;
    if(version<0.0){
        version = [[[self currentDevice] systemVersion] floatValue];
    }
    return version;
}

+ (NSString *)uniqueRunCode{
    static NSString *uniqueCode = nil;
    if(uniqueCode == nil){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd[hh][mm][ss][SSS]"];
        uniqueCode = [[NSString alloc] initWithFormat:@"%@(%d)",[formatter stringFromDate:[NSDate date]],rand()%1000];
    }
    return uniqueCode;
}

+ (DJIDeviceScreenType)currentScreen{
    static DJIDeviceScreenType screen = DJIDeviceScreenTypeUnknown;
    if(screen == DJIDeviceScreenTypeUnknown){
        if([[UIScreen mainScreen] bounds].size.height*768==[[UIScreen mainScreen] bounds].size.width*1024 || [[UIScreen mainScreen] bounds].size.width*768 == [[UIScreen mainScreen] bounds].size.height*1024){
            screen = DJIDeviceScreenType1024x768;
        }
        else if([[UIScreen mainScreen] bounds].size.height*320 == [[UIScreen mainScreen] bounds].size.width*480 || [[UIScreen mainScreen] bounds].size.width*320 == [[UIScreen mainScreen] bounds].size.height*480){
            screen = DJIDeviceScreenType480x320;
        }
        else if([[UIScreen mainScreen] bounds].size.height*320 == [[UIScreen mainScreen] bounds].size.width*568 || [[UIScreen mainScreen] bounds].size.width*320 == [[UIScreen mainScreen] bounds].size.height*568){
            screen = DJIDeviceScreenType568x320;
        }
        else if([[UIScreen mainScreen] bounds].size.height*667 == [[UIScreen mainScreen] bounds].size.width*375 || [[UIScreen mainScreen] bounds].size.width*667 == [[UIScreen mainScreen] bounds].size.height*375){
            screen = DJIDeviceScreenType667x375;
        }
        else if([[UIScreen mainScreen] bounds].size.height*736 == [[UIScreen mainScreen] bounds].size.width*414 || [[UIScreen mainScreen] bounds].size.width*736 == [[UIScreen mainScreen] bounds].size.height*414){
            screen = DJIDeviceScreenType736x414;
        }
    }
    return screen;
}

+ (BOOL)isLandscape{
    if([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft){
        return YES;
    }
    else{
        return NO;
    }
}

+ (NSString*)deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

+ (UIDeviceType)deviceType{
    static UIDeviceType deviceType = UIDeviceType_None;
    if(deviceType == UIDeviceType_None){
        NSString *platform = [self deviceString];
        //由机器原始识别信息自己设定对应的
        if ([platform isEqualToString:@"iPhone1,1"]){
            deviceType = UIDeviceType_iPhone1G;
        }
        else if ([platform isEqualToString:@"iPhone1,2"]){
            deviceType = UIDeviceType_iPhone3G;
        }
        else if ([platform isEqualToString:@"iPhone2,1"]){
            deviceType = UIDeviceType_iPhone3GS;
        }
        else if ([platform isEqualToString:@"iPhone3,1"]||[platform isEqualToString:@"iPhone3,2"]||[platform isEqualToString:@"iPhone3,3"]){
            deviceType = UIDeviceType_iPhone4;
        }
        else if ([platform isEqualToString:@"iPhone4,1"]){
            deviceType = UIDeviceType_iPhone4S;
        }
        else if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"]){
            deviceType = UIDeviceType_iPhone5;
        }
        else if ([platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"]){
            deviceType = UIDeviceType_iPhone5C;
        }
        else if ([platform isEqualToString:@"iPhone6,1"]||[platform isEqualToString:@"iPhone6,2"]){
            deviceType = UIDeviceType_iPhone5S;
        }
        else if([platform isEqualToString:@"iPhone7,1"]){
            deviceType = UIDeviceType_iPhone6;
        }
        else if([platform isEqualToString:@"iPhone7,2"]){
            deviceType = UIDeviceType_iPhone6Plus;
        }
        else if([platform isEqualToString:@"iPhone8,1"]){
            deviceType = UIDeviceType_iPhone6s;
        }
        else if([platform isEqualToString:@"iPhone8,2"]) {
            deviceType = UIDeviceType_iPhone6sPlus;
        }
        else if ([platform isEqualToString:@"iPod1,1"]){
            deviceType = UIDeviceType_iPodTouch1;
        }
        else if ([platform isEqualToString:@"iPod2,1"]){
            deviceType = UIDeviceType_iPodTouch2;
        }
        else if ([platform isEqualToString:@"iPod3,1"]){
            deviceType = UIDeviceType_iPodTouch3;
        }
        else if ([platform isEqualToString:@"iPod4,1"]){
            deviceType = UIDeviceType_iPodTouch4;
        }
        else if ([platform isEqualToString:@"iPod5,1"]){
            deviceType = UIDeviceType_iPodTouch5;
        }
        else if ([platform isEqualToString:@"iPad1,1"]){
            deviceType = UIDeviceType_iPad1;
        }
        else if ([platform isEqualToString:@"iPad2,2"]||[platform isEqualToString:@"iPad2,1"]||[platform isEqualToString:@"iPad2,3"]||[platform isEqualToString:@"iPad2,4"]){
            deviceType = UIDeviceType_iPad2;
        }
        else if ([platform isEqualToString:@"iPad3,1"]||[platform isEqualToString:@"iPad3,2"]){
            deviceType = UIDeviceType_iPad3;
        }
        else if ([platform isEqualToString:@"iPad3,3"]||[platform isEqualToString:@"iPad3,4"]||[platform isEqualToString:@"iPad3,5"]||[platform isEqualToString:@"iPad3,6"]){
            deviceType = UIDeviceType_iPad4;
        }
        else if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||[platform isEqualToString:@"iPad2,7"]){
            deviceType = UIDeviceType_iPadMini;
        }
        else if ([platform isEqualToString:@"iPad4,4"] || [platform isEqualToString:@"iPad4,5"] || [platform isEqualToString:@"iPad4,6"]) {
            deviceType = UIDeviceType_iPadMini2;
        }
        else if ([platform isEqualToString:@"iPad4,7"] || [platform isEqualToString:@"iPad4,8"] || [platform isEqualToString:@"iPad4,9"]) {
            deviceType = UIDeviceType_iPadMini3;
        }
        else if ([platform isEqualToString:@"iPad5,1"] || [platform isEqualToString:@"iPad5,2"]) {
            deviceType = UIDeviceType_iPadMini4;
        }
        else if ([platform isEqualToString:@"iPad4,1"] || [platform isEqualToString:@"iPad4,2"] || [platform isEqualToString:@"iPad4,3"]) {
            deviceType = UIDeviceType_iPadAir;
        }
        else if ([platform isEqualToString:@"iPad5,3"] || [platform isEqualToString:@"iPad5,4"]) {
            deviceType = UIDeviceType_iPadAir2;
        }
        else if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]){
            deviceType = UIDeviceType_Simulator;
        }
    }
    return deviceType;
}


@end
