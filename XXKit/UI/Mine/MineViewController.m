//
//  MineViewController.m
//  XXKit
//
//  Created by tomxiang on 16/3/2.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "MineViewController.h"
#import "utility/XXFPSEngine.h"
#import "UITableView+Global.h"
#import "MineTableCell.h"
#import "MineViewModel.h"
#import "foundationex/UIScreenEx.h"
#import "UITableViewCell+Custom.h"

#define ITEM_CONTENT @"itemContent"
#define ITEM_KEY     @"itemKey"
#define ITEM_ACCOUNT @"itemAccount"
#define ITEM_VALUE @"itemValue"

@interface MineViewController()<UITableViewDelegate,UITableViewDataSource,MineTableCellDelegate>
@property(nonatomic,strong) UITableView *mineTableView;
@property(nonatomic,strong) MineViewModel *mineViewModel;
@end


@implementation MineViewController

-(instancetype)init
{
    if (self = [super init]) {
        self.mineViewModel = [MineViewModel new];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)loadView
{
    [super loadView];
    
    _mineTableView = [UITableView commonGroupStyledTableView:self dataSource:self frame:self.view.bounds];
    [_mineTableView registerClass:[MineTableCell class] forCellReuseIdentifier:MINECELLIDENDIFIFY];
    
    [self.view addSubview:_mineTableView];
}


#pragma mark- Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    NSDictionary * dict = [_mineViewModel getObjectAtIndex:section];
    NSArray * array = [dict objectForKey:ITEM_CONTENT];
    NSDictionary * dictObject = [array objectAtIndex:row];
    NSString * key = [dictObject objectForKey:ITEM_KEY];
    
    if ([key isEqualToString:ITEM_ACCOUNT])
    {
        return _size_H_6(55);
    }
    return _size_H_6(44);
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _size_H_6(20.f);;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == [tableView numberOfSections] - 1) {
        return _size_H_6(20);
    }  else {
        return _size_H_6(0.01);
    }
}

#pragma mark- DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return [_mineViewModel getModelGroupCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary * dict = [_mineViewModel getObjectAtIndex:section];
    NSArray * array = [dict objectForKey:ITEM_CONTENT];
    
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    MineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:MINECELLIDENDIFIFY forIndexPath:indexPath];
    if (cell == nil) {
        cell = (MineTableCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MINECELLIDENDIFIFY];
    }
    
    NSDictionary * dict = [_mineViewModel getObjectAtIndex:section];
    NSArray * array = [dict objectForKey:ITEM_CONTENT];
    NSDictionary * dictObject = [array objectAtIndex:row];
    NSString * value = [dictObject objectForKey:ITEM_VALUE];
    NSString * key = [dictObject objectForKey:ITEM_KEY];
    
    if ([key isEqualToString:@"itemFPS"]) {
        [cell configureDataWithUISwtich:NO tipText:value delegate:self];
    }else{
        [cell configureData:value];
    }
    
    [cell updateBackgroundViewInTableView:tableView atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- MineTableCellDelegate
-(void) switchAction : (BOOL) isOn
{
    if (isOn) {
        [[XXFPSEngine sharedInstance] startMonistor];
    }else{
        [[XXFPSEngine sharedInstance] endMonistor];
    }
}


@end
