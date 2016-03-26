//
//  OSMOIPhoneViewController.h
//  Phantom3
//
//  Created by tomxiang on 3/25/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXViewController.h"

@interface OSMOIPhoneViewController : XXViewController
//ui布局：
/**
 * 放置录像工具条的位置
 */
@property (weak, nonatomic) IBOutlet UIView *captureToolPlaceView;

/**
 * 右侧设置栏
 */
@property (weak, nonatomic) IBOutlet UIView *rightSettingPlaceView;

@end
