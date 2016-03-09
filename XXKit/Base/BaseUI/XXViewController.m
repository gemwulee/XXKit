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
    self.view.backgroundColor = UIColorHex(0xf5f5f8);
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
