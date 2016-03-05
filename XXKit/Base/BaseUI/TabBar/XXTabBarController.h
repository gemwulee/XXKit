//
//  XXTabBarController.h
//  XXKit
//
//  Created by tomxiang on 16/3/2.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXTabBarController : UITabBarController

- (NSUInteger)tabBarIndex;

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;

@end
