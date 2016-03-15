//
//  ContactViewModel.h
//  XXKit
//
//  Created by tomxiang on 16/3/15.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXBaseViewModel.h"

@interface ContactViewModel : XXBaseViewModel

@end

//按拼音排序
NSInteger sortCardInfoByPinying(id obj1, id obj2, void *context);