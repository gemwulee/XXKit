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
#import "OSMOIPhoneViewController.h"
#import "OSMOIPhoneViewController.h"

@implementation DiscoverViewController

-(NSString*) getViewModelFileName{
    return @"DiscoverViewController";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if(indexPath.section == 0 && indexPath.row == 0){
        OSMOIPhoneViewController *osmoVC = [[OSMOIPhoneViewController alloc] initWithNibName:@"OSMOIPhoneViewController" bundle:<#(nullable NSBundle *)#>];
        [self.navigationController presentViewController:osmoVC animated:YES completion:^{}];
    }
}


@end
