//
//  OSMOCaptureModeSelectObject.h
//  XXKit
//
//  Created by tomxiang on 4/6/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSMOCaptureModeSelectObject : NSObject

@property(copy, nonatomic)  NSString *imageViewN;     //正常的图片
@property(copy, nonatomic)  NSString *imageViewS;     //选择后的图片
@property(copy, nonatomic)  NSString *celldentifier;  //加载哪个cell

- (instancetype) initWithDic:(NSDictionary*) dic;

@end
