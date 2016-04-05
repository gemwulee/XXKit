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
#import "DJIIPhoneCameraViewController.h"
#import "OSMOMenuController.h"

@implementation DiscoverViewController

-(NSString*) getViewModelFileName{
    return @"DiscoverViewController";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if(indexPath.section == 0 && indexPath.row == 0){
        OSMOIPhoneViewController *osmoVC = [[OSMOIPhoneViewController alloc] init];
        [self.navigationController presentViewController:osmoVC animated:YES completion:^{}];
    }
    else{
        OSMOMenuController *menuVC = [[OSMOMenuController alloc] initWithPlistKey:MENU_CAMERA_SETTING];

        UINavigationController *osmoNav = [[UINavigationController alloc] initWithRootViewController:menuVC];
        
        [self.navigationController presentViewController:osmoNav animated:YES completion:^{}];

//        [self addChildViewController:menuVC];
//        [self.view addSubview:menuVC.view];
    }
}


@end
