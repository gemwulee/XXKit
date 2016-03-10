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
#import "XXBaseTableCell.h"
#import "XXBaseViewModel.h"
#import "foundationex/UIScreenEx.h"
#import "UITableViewCell+Custom.h"

@interface MineViewController()<BaseTableCellDelegate>
@end

@implementation MineViewController

-(NSString*) getViewModelFileName{
    return @"SettingViewController";
}

#pragma mark- Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    NSDictionary * dict = [self.baseViewModel getObjectAtIndex:section];
    NSArray * array = [dict objectForKey:ITEM_CONTENT];
    NSDictionary * dictObject = [array objectAtIndex:row];
    NSString * key = [dictObject objectForKey:ITEM_KEY];
    
    if ([key isEqualToString:ITEM_ACCOUNT])
    {
        return _size_H_6(55);
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}


#pragma mark- DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    XXBaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:BASECELLIDENDIFIFY forIndexPath:indexPath];
    if (cell == nil) {
        cell = (XXBaseTableCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:BASECELLIDENDIFIFY];
    }
    
    NSDictionary * dict = [self.baseViewModel getObjectAtIndex:section];
    NSArray * array = [dict objectForKey:ITEM_CONTENT];
    NSDictionary * dictObject = [array objectAtIndex:row];
    NSString * value = [dictObject objectForKey:ITEM_VALUE];
    NSString * key = [dictObject objectForKey:ITEM_KEY];
    NSString * imageKey = [dictObject objectForKey:ITEM_IMAGE];
    
    if ([key isEqualToString:@"itemFPS"]) {
        [cell configureDataWithUISwtich:NO tipText:value delegate:self];
    }else{
        [cell configureData:value imageKey:imageKey];
    }
    
    [cell updateBackgroundViewInTableView:tableView atIndexPath:indexPath];
    
    return cell;
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
