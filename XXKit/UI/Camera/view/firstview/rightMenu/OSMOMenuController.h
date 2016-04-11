//
//  OSMOMenuController.h
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "XXViewController.h"
#import "OSMOMenuViewBaseController.h"
#import "OSMOEventAction.h"

#define MENU_CAMERA_SETTING @"cameraSetting" //相机设置

@interface OSMOMenuController : OSMOMenuViewBaseController

-(instancetype)initWithPlistKey:(NSString*) plistkey withModel:(DJIIPhoneCameraModel*) model camera:(OSMOEventAction*) cameraAction;

-(void) refreshViewForIPhoneCameraMode;

@end
