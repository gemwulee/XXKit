//
//  HomeViewController.m
//  XXKit
//
//  Created by tomxiang on 16/2/27.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableCell.h"
#import "UITableView+Global.h"
#import "XXBase.h"
#import "SDAnalogDataGenerator.h"
#import "XXMessageModel.h"
#import "UITableViewCell+Custom.h"

//https://github.com/gsdios/GSD_WeiXin

@interface HomeViewController()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *xxTableView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation HomeViewController

-(instancetype)init
{
    if (self = [super init]) {
        [self setupDataWithCount:24];
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    _xxTableView = [UITableView commonPlainStyledTableView:self dataSource:self frame:self.view.bounds];
    [_xxTableView registerClass:[HomeTableCell class] forCellReuseIdentifier:XXCELLIDENDIFIFY];
    
    [self.view addSubview:_xxTableView];
}

- (void)setupDataWithCount:(NSInteger)count
{
    self.dataArray = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        XXMessageModel *model = [XXMessageModel new];
        model.imageName = [SDAnalogDataGenerator indexImageName:i];
        model.name = [SDAnalogDataGenerator indexName:i];
        model.message = [SDAnalogDataGenerator indexMessage:i];
        [self.dataArray addObject:model];
    }
}

#pragma mark- Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _size_H_6(60.f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"关注" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了关注");
        
        // 收回左滑出现的按钮(退出编辑模式)
        tableView.editing = NO;
    }];
    
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    return @[action1, action0];
}


#pragma mark- DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:XXCELLIDENDIFIFY forIndexPath:indexPath];
    
    XXMessageModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell configureForData:model row:indexPath.row];
    [cell updateBackgroundViewInTableView:tableView atIndexPath:indexPath];
    return cell;
}
@end
