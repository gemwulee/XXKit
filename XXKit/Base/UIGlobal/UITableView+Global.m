//
//  UITableView+Global.m
//  XXKit
//
//  Created by tomxiang on 16/3/5.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "UITableView+Global.h"
#import "foundationex/UIColorEx.h"

@implementation UITableView (Global)

+ (UITableView*)commonGroupStyledTableView:(id <UITableViewDelegate>)delegate dataSource:(id <UITableViewDataSource>) dataSource frame:(CGRect)frame
{
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    //    CZ_SetClearBackgroundColor(tableView);
    [tableView setBackgroundColor:[UIColor clearColor]];
    
    tableView.backgroundView = nil;
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [tableView setCurrentThemeSeparatorColor];
    
    return tableView;
}

+ (UITableView*)commonPlainStyledTableView:(id <UITableViewDelegate>)delegate dataSource:(id <UITableViewDataSource>) dataSource frame:(CGRect)frame
{
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [tableView setBackgroundColor:[UIColor blackColor]];
    tableView.backgroundView = nil;
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [tableView setCurrentThemeSeparatorColor];
    [tableView removeExtraSeparatorLine];
    
    return tableView;
}

- (void)setCurrentThemeSeparatorColor
{
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.separatorColor = UIColorHex(0xdedfe0);
}

- (void)removeExtraSeparatorLine
{
    if (self.tableFooterView == nil) {
        UIView* footerView = [UIView new];
        [footerView setBackgroundColor:[UIColor clearColor]];
        self.tableFooterView = footerView;
    }
}

@end
