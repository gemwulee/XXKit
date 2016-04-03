//
//  OSMOToolWindow.m
//  XXKit
//
//  Created by tomxiang on 4/3/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOToolWindow.h"
#import "XXBase.h"
#import "OSMOToolViewController.h"

@interface OSMOToolWindow()
@end

@implementation OSMOToolWindow

-(instancetype)initWithFrame:(CGRect)frame
          toolViewController:(OSMOToolViewController*) toolViewcontroller
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setWindowLevel:UIWindowLevelAlert + 10000000];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        self.rootViewController = toolViewcontroller;
    }
    return self;
}

-(void) showOSMOToolVC
{
    [self setHidden:NO];
}

-(void) hideOSMOToolVC
{
    [self setHidden:YES];
}

@end
