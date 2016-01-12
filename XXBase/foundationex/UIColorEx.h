//
//  UIColorEx.h
//  XXBase
//
//  Created by tomxiang on 16/1/12.
//  Copyright © 2016年 tomxiang. All rights reserved.
//
#import <UIKit/UIKit.h>
/*
 Create UIColor with a hex string.
 Example: UIColorHex(0xF0F), UIColorHex(66ccff), UIColorHex(#66CCFF88)
 
 Valid format: #RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB ...
 The `#` or "0x" sign is not required.
 */
#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif


@interface UIColor(Ex)
- (BOOL)isEqualToColor:(UIColor*)color;
@end
