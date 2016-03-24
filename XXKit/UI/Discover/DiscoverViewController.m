//
//  DiscoverViewController.m
//  XXKit
//
//  Created by tomxiang on 16/3/2.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "DiscoverViewController.h"
#import "XXBaseTableCell.h"
#import "XXBaseViewModel.h"
#import "OSMOPhoneController.h"

@implementation DiscoverViewController

-(NSString*) getViewModelFileName{
    return @"DiscoverViewController";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    OSMOPhoneController *osmoVC = [[OSMOPhoneController alloc] init];
    osmoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:osmoVC animated:YES];
    
}


@end
