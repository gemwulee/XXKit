//
//  XXThemeConfig.h
//  XXKit
//
//  Created by tomxiang on 16/3/5.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXThemeConfig : NSObject

+ (instancetype) sharedInstance;

- (void) refreshTheme:(NSString*) fileName;

@end
