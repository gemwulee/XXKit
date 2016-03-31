//
//  UITableView+DJIUIKit.h
//  DJIMidware
//
//  Created by Jerome.zhang on 14-7-9.
//  Copyright (c) 2014年 Jerome.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DJIUIKit)

/**
 *  将tableView风格还原成iOS6,在willDisplayCell的方法中调用该方法即可。
 *
 *  @param tableView 列表View
 *  @param cell      即将显示的cell
 *  @param indexPath 位置
 *  @param color     背景的颜色
 */
+ (void)roundedTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withSectionColor:(UIColor *)color;

+ (void)roundedTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withSectionColor:(UIColor *)color selectedColor:(UIColor *)selectedColor;

+ (void)roundedHandleTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withSectionColor:(UIColor *)color selectedColor:(UIColor *)selectedColor;

+ (void)roundedMenuTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withSectionColor:(UIColor *)color selectedColor:(UIColor *)selectedColor;


- (UITableViewCell*)dequeueReusableCellWithDJICellClass:(Class)cellClass;

@end
