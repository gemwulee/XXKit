//
//  AppDelegate.m
//  XXKit
//
//  Created by tomxiang on 16/1/6.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "AppDelegate.h"
#import "XXTabBarItem.h"
#import "XXNavigationController.h"
#import "FPSViewController.h"
#import "CallViewController.h"
#import "MineViewController.h"
#import "WorldViewController.h"
#import "XXTabBar.h"
#import "XXTabBarController.h"
#import "NSObject+SwizzleMethod.h"

#define XX_MESSAGE @"XX"
#define XX_CALL @"电话"
#define XX_WORLD @"特产"
#define XX_ME @"我"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [NSObject switchAllMethod];
    
    [self launchAfterGuideWindow];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)launchAfterGuideWindow
{
    [self initUI];
}


#pragma mark- UI
- (void) initUI
{
    FPSViewController  *fpsVC  = [FPSViewController new];
    CallViewController *callVC = [CallViewController new];
    WorldViewController *worldVC = [WorldViewController new];
    MineViewController *mineVC = [MineViewController new];
    
    fpsVC.title = XX_MESSAGE;
    callVC.title = XX_CALL;
    worldVC.title = XX_WORLD;
    mineVC.title = XX_ME;

    //动态0
    XXTabBarItem *item0 = [[XXTabBarItem alloc] initWithTitle:XX_MESSAGE tag:0];
    item0.normalImageName = @"tab_recent_nor.png";
    item0.hiImageName = @"tab_recent_press.png";
    
    XXNavigationController * navTabCtr0 = [XXNavigationController newWithRootViewController:fpsVC];
    navTabCtr0.tabBarItem = item0;
    
    //动态1
    XXTabBarItem *item1 = [[XXTabBarItem alloc] initWithTitle:XX_CALL tag:1];
    item1.normalImageName =  @"tab_call_nor.png";
    item1.hiImageName = @"tab_call_press.png";
    XXNavigationController * navTabCtr1 = [XXNavigationController newWithRootViewController:callVC];
    navTabCtr1.tabBarItem = item1;
    
    //动态2
    XXTabBarItem *item2 = [[XXTabBarItem alloc] initWithTitle:XX_WORLD tag:2];
    item2.normalImageName = @"tab_qworld_nor.png";
    item2.hiImageName = @"tab_qworld_press.png";
    XXNavigationController * navTabCtr2 = [XXNavigationController newWithRootViewController:worldVC];
    navTabCtr2.tabBarItem = item2;
    
    //动态3
    XXTabBarItem *item3 = [[XXTabBarItem alloc] initWithTitle:XX_ME tag:3];
    item3.normalImageName = @"tab_buddy_nor.png";
    item3.hiImageName = @"tab_buddy_press.png";
    XXNavigationController * navTabCtr3 = [XXNavigationController newWithRootViewController:mineVC];
    navTabCtr3.tabBarItem = item3;
    
    NSArray * arr = [NSArray arrayWithObjects:navTabCtr0,navTabCtr1,navTabCtr2,navTabCtr3,nil];

    self.tabCtr = [XXTabBarController new];
    [self.tabCtr setViewControllers:arr animated:NO];
    
    self.window.rootViewController = self.tabCtr;
    [self.window makeKeyAndVisible];
}

@end
