//
//  OSMOIPhoneViewController.h
//  Phantom3
//
//  Created by tomxiang on 3/25/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXViewController.h"

@class OSMOToolViewController;
@class DJIIPhoneCameraViewController;
@class OSMOStatusObserveManager;

@interface OSMOIPhoneViewController : XXViewController

@property(nonatomic,strong)  DJIIPhoneCameraViewController  *cameraVC;
@property(nonatomic,strong)  OSMOToolViewController *toolVC;

@property(nonatomic,strong)  OSMOStatusObserveManager *observeManager;

@end
