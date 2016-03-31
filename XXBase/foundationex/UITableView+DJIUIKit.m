//
//  UITableView+DJIUIKit.m
//  DJIMidware
//
//  Created by Jerome.zhang on 14-7-9.
//  Copyright (c) 2014年 Jerome.zhang. All rights reserved.
//

#import "UITableView+DJIUIKit.h"

@implementation UITableView (DJIUIKit)

+ (void)roundedTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withSectionColor:(UIColor *)color selectedColor:(UIColor *)selectedColor
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        CGFloat cornerRadius = 5.f;
        cell.backgroundColor = UIColor.clearColor;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
        
        CAShapeLayer *selectedLayer = [[CAShapeLayer alloc] init];
        
        BOOL addTopLine = NO;
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            addLine = YES;
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
            addLine = YES;
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            addLine = YES;
            
        } else {
            
            CGPathAddRect(pathRef, nil, bounds);
            
            addLine = YES;
            
        }
        
        layer.path = pathRef;
        selectedLayer.path = pathRef;
        
        CFRelease(pathRef);
        
        layer.fillColor = color.CGColor;
        if (selectedColor) {
            selectedLayer.fillColor = selectedColor.CGColor;
        }
        
        if (addTopLine == YES) {
            
            CALayer *lineLayer = [[CALayer alloc] init];
            
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, 0, bounds.size.width-20, lineHeight);
            
            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
            
            [layer addSublayer:lineLayer];
            
        }
        
        if (addLine == YES) {
            
            CALayer *lineLayer = [[CALayer alloc] init];
            
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-20, lineHeight);
            
            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
            
            [layer addSublayer:lineLayer];
            
        }
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        
        [testView.layer insertSublayer:layer atIndex:0];
        
        testView.backgroundColor = UIColor.clearColor;
        
        cell.backgroundView = testView;
        
        if (selectedColor) {
            UIView *backgroundView = [[UIView alloc] initWithFrame:bounds];
            [backgroundView.layer insertSublayer:selectedLayer atIndex:0];
            backgroundView.backgroundColor = [UIColor clearColor];
            cell.selectedBackgroundView = backgroundView;
        }
        
    }
}


+ (void)roundedHandleTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withSectionColor:(UIColor *)color selectedColor:(UIColor *)selectedColor
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        cell.backgroundColor = UIColor.clearColor;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
        
        CAShapeLayer *selectedLayer = [[CAShapeLayer alloc] init];
       
        //选中区域:
        CGPathAddRect(pathRef, nil, cell.bounds);
        
        //下划线
        CALayer *lineLayer = [[CALayer alloc] init];
        
        CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
        
        lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width, lineHeight);
        
        lineLayer.backgroundColor = tableView.separatorColor.CGColor;
        
        [layer addSublayer:lineLayer];
            
        
        layer.path = pathRef;
        selectedLayer.path = pathRef;
        
        CFRelease(pathRef);
        
        layer.fillColor = color.CGColor;
        if (selectedColor) {
            selectedLayer.fillColor = selectedColor.CGColor;
        }
        
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        
        [testView.layer insertSublayer:layer atIndex:0];
        
        testView.backgroundColor = UIColor.clearColor;
        
        cell.backgroundView = testView;
        
        if (selectedColor) {
            UIView *backgroundView = [[UIView alloc] initWithFrame:bounds];
            [backgroundView.layer insertSublayer:selectedLayer atIndex:0];
            backgroundView.backgroundColor = [UIColor clearColor];
            cell.selectedBackgroundView = backgroundView;
        }
        
    }
}


+ (void)roundedMenuTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withSectionColor:(UIColor *)color selectedColor:(UIColor *)selectedColor
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        cell.backgroundColor = UIColor.clearColor;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 0, 0);
        
        CAShapeLayer *selectedLayer = [[CAShapeLayer alloc] init];
        
        //选中区域:
        CGPathAddRect(pathRef, nil, cell.bounds);
        
        //下划线
        CALayer *lineLayer = [[CALayer alloc] init];
        
        CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
        
        lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
        
        lineLayer.backgroundColor = tableView.separatorColor.CGColor;
        
        [layer addSublayer:lineLayer];
        
        
        layer.path = pathRef;
        selectedLayer.path = pathRef;
        
        CFRelease(pathRef);
        
        layer.fillColor = color.CGColor;
        if (selectedColor) {
            selectedLayer.fillColor = selectedColor.CGColor;
        }
        
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        
        [testView.layer insertSublayer:layer atIndex:0];
        
        testView.backgroundColor = UIColor.clearColor;
        
        cell.backgroundView = testView;
        
        if (selectedColor) {
            UIView *backgroundView = [[UIView alloc] initWithFrame:bounds];
            [backgroundView.layer insertSublayer:selectedLayer atIndex:0];
            backgroundView.backgroundColor = [UIColor clearColor];
            cell.selectedBackgroundView = backgroundView;
        }
        
    }
}

+ (void)roundedTableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withSectionColor:(UIColor *)color{
    [self roundedTableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath withSectionColor:color selectedColor:nil];
}

- (UITableViewCell*) dequeueReusableCellWithDJICellClass:(Class)cellClass {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
}

@end
