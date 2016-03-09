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
#import "XXTabBar.h"
#import "XXTabBarController.h"
#import "NSObject+SwizzleMethod.h"
#import "XXThemeConfig.h"
#import "XXViewController.h"

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

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
    [self loadDefaultTheme];
}

#pragma mark- 加载默认主题
-(void) loadDefaultTheme
{
    [[XXThemeConfig sharedInstance] refreshTheme:@"DefaultThemeConfig"];
}

#pragma mark- UI
- (void) initUI
{
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"HomeViewController",
                                   kTitleKey  : @"微信",
                                   kImgKey    : @"tabbar_mainframe",
                                   kSelImgKey : @"tabbar_mainframeHL"},
                                 
                                 @{kClassKey  : @"ContactsViewController",
                                   kTitleKey  : @"通讯录",
                                   kImgKey    : @"tabbar_contacts",
                                   kSelImgKey : @"tabbar_contactsHL"},
                                 
                                 @{kClassKey  : @"DiscoverViewController",
                                   kTitleKey  : @"发现",
                                   kImgKey    : @"tabbar_discover",
                                   kSelImgKey : @"tabbar_discoverHL"},
                                 
                                 @{kClassKey  : @"MineViewController",
                                   kTitleKey  : @"我",
                                   kImgKey    : @"tabbar_me",
                                   kSelImgKey : @"tabbar_meHL"} ];
    
    NSMutableArray * arrVC = [NSMutableArray array];
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        XXViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        
        XXNavigationController *nav = [[XXNavigationController alloc] initWithRootViewController:vc];
        XXTabBarItem *item = [[XXTabBarItem alloc] initWithTitle:dict[kTitleKey] tag:idx];
       
        item.normalImageName = dict[kImgKey];
        item.hiImageName = dict[kSelImgKey];
        nav.tabBarItem = item;
        [arrVC addObject:nav];
    }];

    self.tabCtr = [XXTabBarController new];
    [self.tabCtr setViewControllers:arrVC animated:NO];
    
    self.window.rootViewController = self.tabCtr;
    [self.window makeKeyAndVisible];
    
    [self initNavBar];
}

#pragma mark- Navigation

- (void) initNavBar
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UINavigationBar *bar = [UINavigationBar appearance];
    CGFloat rgb = 0.1;
    bar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
    bar.tintColor = [UIColor whiteColor];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}
@end
