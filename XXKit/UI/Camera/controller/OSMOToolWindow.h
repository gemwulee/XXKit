//
//  OSMOToolWindow.h
//  XXKit
//
//  Created by tomxiang on 4/3/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OSMOToolViewController;

@interface OSMOToolWindow : UIWindow

-(instancetype)initWithFrame:(CGRect)frame toolViewController:(OSMOToolViewController*) toolViewcontroller;


-(void) showOSMOToolVC;

-(void) hideOSMOToolVC;

@end
