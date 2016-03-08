//
//  UIImage+TintColor.h
//  XXBase
//
//  Created by tomxiang on 16/3/8.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TintColor)

/**
 *  没有渐变颜色的图片使用此方法进行着色,保留透明度
 *
 *  @param tintColor 图片颜色
 *
 *  @return 着色后的图片
 */
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;

/**
 *  改变图片透明度,生成半透明按压效果图
 *
 *  @param alpha 透明度
 *
 *  @return 改变透明度后的图片
 */
- (UIImage *) imageWithAlpha:(CGFloat)alpha;

@end
