//
//  NSObject+SwizzleMethod.m
//  XXKit
//
//  Created by tomxiang on 16/3/4.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "NSObject+SwizzleMethod.h"
#import "UIViewController+SwizzleMethod.h"


#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation NSObject (SwizzleMethod)

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)altSel
{
    Method originMethod = class_getInstanceMethod(self, origSel);
    Method newMethod = class_getInstanceMethod(self, altSel);
    
    if (originMethod && newMethod) {
        //2012年5月更新
        if (class_addMethod(self, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
            class_replaceMethod(self, altSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, newMethod);
        }
        return YES;
    }
    return NO;
}

+ (BOOL)swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)altSel
{
    Class c = object_getClass((id)self);
    return [c swizzleMethod:origSel withMethod:altSel];
}

// 这个方法是把所有替换所有类的方法
+ (void)switchAllMethod
{
    [UIViewController swizzleMethod:@selector(XXViewDidAppear:) withMethod:@selector(viewDidAppear:)];
    
    
    
}

@end
