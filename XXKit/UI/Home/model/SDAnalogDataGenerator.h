//
//  SDAnalogDataGenerator.h
//  GSD_WeiXin(wechat)
//
//  Created by aier on 16/2/10.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDAnalogDataGenerator : NSObject

+ (NSString *)randomName;
+ (NSString *)randomIconImageName;
+ (NSString *)randomMessage;

+ (NSString *)indexName:(NSInteger) index;
+ (NSString *)indexImageName:(NSInteger) index;
+ (NSString *)indexMessage:(NSInteger) index;

@end
