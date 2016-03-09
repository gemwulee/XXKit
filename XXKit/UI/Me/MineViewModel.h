//
//  MineViewModel.h
//  XXKit
//
//  Created by tomxiang on 16/3/5.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineViewModel : NSObject

//获取模型分组总数据
-(NSUInteger) getModelGroupCount;

//获取每一组的数据
-(NSDictionary*) getObjectAtIndex:(NSUInteger) section;

@end
