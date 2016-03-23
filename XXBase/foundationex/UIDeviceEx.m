//
//  UIDeviceEx.m
//  XXBase
//
//  Created by tomxiang on 16/1/12.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "UIDeviceEx.h"

@implementation UIDevice(Ex)

+ (BOOL)isLandscape{
    if([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft){
        return YES;
    }
    else{
        return NO;
    }
}

@end
