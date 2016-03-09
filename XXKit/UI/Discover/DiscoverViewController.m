//
//  DiscoverViewController.m
//  XXKit
//
//  Created by tomxiang on 16/3/2.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "DiscoverViewController.h"
#import "foundationex/UIImage+TintColor.h"

@implementation DiscoverViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    
    UIImage *imageCardList = [UIImage imageNamed:@"card_list_icon"];
    
    imageCardList = [imageCardList imageWithTintColor:[UIColor orangeColor]];
    
    imageView.image = imageCardList;
    
    
    
    [self.view addSubview:imageView];
}

@end
