//
//  UIColorEx.m
//  XXBase
//
//  Created by tomxiang on 16/1/12.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "UIColorEx.h"

@implementation UIColorEx

- (BOOL)isEqualToColor:(UIColor*)color
{
    CGFloat lr,lg,lb,la;
    CGFloat gr,gg,gb,ga;
    
    [self getRed:&lr green:&lg blue:&lb alpha:&la];
    [color getRed:&gr green:&gg blue:&gb alpha:&ga];
    
    
    return (lr==gr)&&(lg==gg)&&(lb==gb)&&(la==ga);
}

@end
