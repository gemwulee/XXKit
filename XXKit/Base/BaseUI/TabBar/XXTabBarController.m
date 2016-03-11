//
//  XXTabBarController.m
//  XXKit
//
//  Created by tomxiang on 16/3/2.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "XXTabBarController.h"
#import "XXTabBar.h"
#import "UIViewController+SwizzleMethod.h"
#import "UISCreenEx.h"

@interface XXTabBarController()<XXTabBarDelegate>
@property(strong, nonatomic) XXTabBar* tabBarView; // 覆盖uiTabBar的
@end

@implementation XXTabBarController

-(instancetype)init
{
    if (self = [super init]) {
        _tabBarView = [[XXTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, XXVIEW_CONTROLLER_TOOLBAR_HEIGHT)];
        _tabBarView.userInteractionEnabled = YES; //这一步一定要设置为YES，否则不能和用户交互
        _tabBarView.delegate = self;
    }
    return self;
}

- (NSUInteger)tabBarIndex
{
    return self.selectedIndex;
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    [super setViewControllers:viewControllers animated:animated];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];

    for (UIView *subView in self.tabBar.subviews) {
        [subView removeFromSuperview];
    }
    
    [self.tabBar addSubview: _tabBarView];
    [_tabBarView setViewControllers:viewControllers];
}

#pragma mark- delegate
- (void)XXTabBar:(XXTabBar*)tabBar singleClickItemAtIndex:(NSInteger)index
{
    
    if (self.selectedIndex != index){
        self.selectedIndex = index;
        self.selectedViewController = [self.viewControllers objectAtIndex:index];
    }
}

@end
