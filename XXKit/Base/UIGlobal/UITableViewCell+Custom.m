//
//  UITableViewCell+Custom.m
//  XXKit
//
//  Created by tomxiang on 16/3/5.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "UITableViewCell+Custom.h"
#import "XXGlobalColor.h"

@implementation UITableViewCell (Custom)

- (void) setCustomAccessoryViewEnabled:(BOOL)enabled {
    if (enabled) {
        //self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImage* access = [UIImage imageNamed:@"table_arrow.png"];
        //stanfani:手Q5.0 Redesign项目
        //UIImage* accessHighted = LOAD_ICON_USE_POOL_USE_CACHE(@"table_arrow_press.png");
        UIImageView* view = [[UIImageView alloc] initWithImage:access];
        view.image = access;
        self.accessoryView = view;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.accessoryView = nil;
    }
}

- (void)updateBackgroundViewInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath
{
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    NSInteger rows = [tableView.dataSource tableView:tableView numberOfRowsInSection:section];
    
    // QQ5.0 普通状态下用色值代替
    UIColor * color = QQGLOBAL_COLOR(kTableViewCellBackgroundColorNormal);
    [self setBackgroundColor:QQGLOBAL_COLOR(kTableViewCellBackgroundColorNormal)];
    // 按下背景图
    [self updateSelectedBackgroundViewAtRow:row sectionRows:rows];
}

- (void)updateSelectedBackgroundViewAtRow:(NSInteger)row sectionRows:(NSInteger)rows
{
    // 按下状态，纯色贴图
    // FTS Install Package
    /*if (1) {*/
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectZero];
    [bgView setBackgroundColor:QQGLOBAL_COLOR(kTableViewCellBackgroundColorHighlighted)];

    self.selectedBackgroundView = bgView;
}
@end
