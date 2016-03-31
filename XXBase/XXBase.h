//
//  XXBase.h
//  XXBase
//
//  Created by XiangChenyu on 16/1/23.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "foundationex/NSStringEx.h"
#import "foundationex/UISCreenEx.h"
#import "foundationex/UIColorEx.h"
#import "foundationex/UIDeviceEx.h"
#import "foundationex/UIView+Common.h"


#import "macro/XXMacro.h"

#import "utility/XXFPSEngine.h"

#import "uikit/XXButton.h"
#import "foundationex/UIDevice+DJIUIKit.h"


#define weakSelf(__TARGET__) __weak typeof(self) __TARGET__=self
#define weakReturn(__TARGET__) if(__TARGET__==nil)return;


@interface XXBase : NSObject

@end
