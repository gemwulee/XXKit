//
//  UIViewController+SwizzleMethod.m
//  XXKit
//
//  Created by tomxiang on 16/3/3.
//  Copyright © 2016年 tomxiang. All rights reserved.
//
#import "UIViewController+SwizzleMethod.h"
#import <objc/runtime.h>

@implementation UIViewController (SwizzleMethod)

- (void)XXViewDidAppear:(BOOL)animated
{
    [self XXViewDidAppear:animated];
    [UIView setAnimationsEnabled:YES];
}

- (void)XXViewDidDisappear:(BOOL)animated
{
    [self XXViewDidDisappear:animated];
}

- (void)XXViewWillDisappear:(BOOL)animated
{
    [self XXViewWillDisappear:animated];
}

@end
