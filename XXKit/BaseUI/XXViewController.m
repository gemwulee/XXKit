//
//  XXViewController.m
//  XXKit
//
//  Created by tomxiang on 16/1/11.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "XXViewController.h"
#import "XXBase.h"

@implementation XXViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0xfd/255.0 green:0xfe/255.0 blue:0xf9/255.0 alpha:1]];
}

-(instancetype)init
{
    if(self = [super init]){
        [self initViewController];
    }
    return self;
}

-(void) initViewController
{
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

@end
