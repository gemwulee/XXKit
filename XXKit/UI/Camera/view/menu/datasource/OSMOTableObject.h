//
//  OSMOTableDataSource.h
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSMOTableObject : NSObject

@property(copy, nonatomic)  NSString *celldentifier;  //加载哪个cell
@property(copy, nonatomic)  NSString *titleL;         //左侧的名字

@property(copy, nonatomic)  NSString *labelR;         //右侧的label名字
@property(copy, nonatomic)  NSString *imageViewR;     //label右侧的图片

@property(assign, nonatomic)  BOOL swtichR;             //是否有switch
@property(assign, nonatomic)  BOOL showRightSideImage;  //右边箭头图或加号图

- (instancetype) initWithDic:(NSDictionary*) dic;

@end
