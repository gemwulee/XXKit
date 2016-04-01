//
//  OSMOIPhoneViewController.h
//  Phantom3
//
//  Created by tomxiang on 3/25/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXViewController.h"

#define paramSettingWidth  (IS_IPHONE5?60:80)
#define rightBarWidth 44

#define timelapseHeight  (IS_IPAD?355.0:(IS_IPHONE5?240.0:(IS_IPHONE6?295:334)))

@class OSMOCaptureToolView;
@class OSMORightSettingView;
@class OSMOLeftFirstMenuPlaceView;
@class OSMOLeftSecondMenuPlaceView;
@class OSMORightFirstMenuPlaceView;
@class DJIIPhoneCameraViewController;



@interface OSMOIPhoneViewController : XXViewController

@property(nonatomic,strong)  OSMOCaptureToolView  *captureToolPlaceView;
@property(nonatomic,strong)  OSMORightSettingView *rightSettingPlaceView;

/**
 * 左侧一级设置栏弹框
 */
@property (strong, nonatomic) OSMOLeftFirstMenuPlaceView *leftFirstMenuPlaceView;

/**
 * 左侧二级设置栏弹框
 */
@property (strong, nonatomic) OSMOLeftSecondMenuPlaceView *leftSecondMenuPlaceView;

/**
 * 右侧一级设置栏弹框
 */
@property (strong, nonatomic) OSMORightFirstMenuPlaceView *rightFirstMenuPlaceView;


@property(nonatomic,strong)  DJIIPhoneCameraViewController  *cameraVC;

@end
