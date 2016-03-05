//
//  XXTabBar.h
//  XXKit
//
//  Created by tomxiang on 16/3/3.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XXVIEW_CONTROLLER_TOOLBAR_HEIGHT (49)


@class XXTabBar;
@protocol XXTabBarDelegate <NSObject>
@required
- (void)XXTabBar:(XXTabBar*)tabBar singleClickItemAtIndex:(NSInteger)index;
@end

@interface XXTabBar : UIView

@property(nonatomic,weak) id<XXTabBarDelegate> delegate;

- (void)setViewControllers:(NSArray*)viewControllers;

@end
