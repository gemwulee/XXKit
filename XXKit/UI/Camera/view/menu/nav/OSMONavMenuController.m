//
//  OSMONavMenuController.m
//  XXKit
//
//  Created by tomxiang on 4/1/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMONavMenuController.h"

@implementation OSMONavMenuController

//-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
//{
//    if (self = [super initWithRootViewController:rootViewController]) {
//         [self.navigationBar setTranslucent:NO];
//         [self.navigationBar setBackgroundColor:[UIColor blackColor]];
//    }
//    return self;
//}
//
//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
//
//-(void)popself{
//    [self popViewControllerAnimated:YES];
//}
//
//-(UIBarButtonItem*) createBackButton
//{
//    UIImage* image= [UIImage imageNamed:@"back_arrow"];
//    
//    CGRect backframe= CGRectMake(0, 0, image.size.width, image.size.height);
//    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
//    backButton.frame = backframe;
//    
//    [backButton setBackgroundImage:image forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
//   
//    //定制自己的风格的  UIBarButtonItem
//    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    return someBarButtonItem;
//}
//
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [super pushViewController:viewController animated:animated];
//    
//    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1){
//        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
//        
//
//
//    }
//    
//}



@end
