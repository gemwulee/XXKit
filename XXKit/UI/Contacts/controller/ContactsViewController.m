//
//  ContactsViewController.m
//  XXKit
//
//  Created by tomxiang on 16/3/2.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactViewModel.h"

@implementation ContactsViewController

-(NSString*) getViewModelFileName{
    return @"ContactConfig";
}

-(instancetype)init
{
    if (self = [super init]) {
        self.baseViewModel = [[ContactViewModel alloc] initWithFileName:[self getViewModelFileName]];
    }
    return self;
}

@end
