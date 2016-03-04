//
//  UIViewController+SwizzleMethod.h
//  XXKit
//
//  Created by tomxiang on 16/3/3.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SwizzleMethod)

- (void)XXViewDidAppear:(BOOL)animated;


- (void)XXViewDidDisappear:(BOOL)animated;


- (void)XXViewWillDisappear:(BOOL)animated;

@end

