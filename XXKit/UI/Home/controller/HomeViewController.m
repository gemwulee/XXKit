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
       
        NSString *imageName = [SDAnalogDataGenerator indexImageName:i];
        NSString *name = [SDAnalogDataGenerator indexName:i];
        NSString *message = [SDAnalogDataGenerator indexMessage:i];
        
        XXMessageModel *model = [[XXMessageModel alloc] initWithModel:imageName name:name message:message seq:0];
        
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

#pragma mark- 左滑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}
//此方法必须执行，否则会有问题
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        [self.dataArray removeObjectAtIndex:indexPath.row];
//        [self.xxTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.xxTableView reloadData];
        
    }];
    
    //设置未读按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSObject *object = [self.dataArray objectAtIndex:indexPath.row];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.dataArray insertObject:object atIndex:0];
        
        [self.xxTableView reloadData];
        
    }];
    
    topRowAction.backgroundColor = [UIColor grayColor];

    return  @[deleteRowAction,topRowAction];
}


#pragma mark- DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
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
