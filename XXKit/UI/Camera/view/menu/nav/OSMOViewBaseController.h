//
//  OSMOViewBaseController.h
//  XXKit
//
//  Created by tomxiang on 4/1/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define OSMO_NAV_HEIGHT (40.f)

@interface OSMOViewBaseController : UIViewController

@property(nonatomic,strong) UIView *mainView;

-(void) setTextTitle:(NSString*) title;
@end
