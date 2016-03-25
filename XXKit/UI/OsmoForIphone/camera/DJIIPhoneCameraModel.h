//
//  DJIIPhoneCameraModel.h
//  Phantom3
//
//  Created by tomxiang on 3/24/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJIIPhoneConfig.h"
#import <UIKit/UIKit.h>

@interface DJIIPhoneCameraModel : NSObject

//摄像头方向，默认后置
@property(nonatomic,assign) DJIIPhoneCameraPosition devicePosition;

//快门
@property(nonatomic,assign) CGFloat shutter;

//ISO
@property(nonatomic,assign) CGFloat iSO;

@end
