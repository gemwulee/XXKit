//
//  OSMOMenuController.h
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "XXViewController.h"
#import "OSMOViewBaseController.h"

#define MENU_CAMERA_SETTING @"cameraSetting" //相机设置

@interface OSMOMenuController : OSMOViewBaseController

-(instancetype)initWithPlistKey:(NSString*) plistkey;

@end
