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
    self.devicePosition = DJIIPhoneDevicePositionBack;
    
    
}

@end
