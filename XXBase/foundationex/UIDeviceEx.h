//
//  UIDeviceEx.h
//  XXBase
//
//  Created by tomxiang on 16/1/12.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif
    double qq_getSystemVersion();
#ifdef __cplusplus
}
#endif

#define SYSTEM_VERSION qq_getSystemVersion()


@interface UIDevice(Ex)

@end
