//
//  OSMOMenuController.h
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "XXViewController.h"

#define MENU_CAMERA_SETTING @"cameraSetting" //相机设置

@interface OSMOMenuController : XXViewController

-(instancetype)initWithPlistKey:(NSString*) plistkey;

@end
