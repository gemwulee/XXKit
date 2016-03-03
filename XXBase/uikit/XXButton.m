//
//  XXButton.m
//  XXBase
//
//  Created by tomxiang on 16/3/3.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "XXButton.h"

@implementation XXButton

- (void) setImage:(UIImage *)image selectImage:(UIImage*) selectImage withTitle:(NSString *)title
{
    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:10.F]];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              0.0,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:selectImage forState:UIControlStateSelected];
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:10.F]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(35.0,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:UIControlStateNormal];
}

@end
