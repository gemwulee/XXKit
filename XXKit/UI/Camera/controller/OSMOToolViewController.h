//
//  OSMOToolViewController.h
//  XXKit
//
//  Created by tomxiang on 4/3/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "XXViewController.h"

#define paramSettingWidth  (IS_IPHONE5?60:80)
#define rightBarWidth 44

#define timelapseHeight  (IS_IPAD?355.0:(IS_IPHONE5?240.0:(IS_IPHONE6?295:334)))

#define osmoMenumodeViewHeight  40


@class OSMOCaptureToolView;
@class OSMORightSettingView;
@class OSMOMenuPlaceView;
@class DJIIPhoneCameraViewController;
@class OSMOToolViewController;
@class OSMOEventAction;
@class DJIIPhoneCameraModel;
@class OSMOManualmodeView;

@interface OSMOToolViewController : XXViewController


-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model action:(OSMOEventAction*) action;

/**
 * 左侧原始设置栏弹框
 */
@property(nonatomic,strong) OSMOCaptureToolView  *captureToolPlaceView;

/**
 * 右侧原始设置栏弹框
 */
@property(nonatomic,strong) OSMORightSettingView *rightSettingPlaceView;

/**
 * 左侧一级设置栏弹框
 */
@property(nonatomic,strong) OSMOMenuPlaceView *leftFirstMenuPlaceView;

/**
 * 左侧二级设置栏弹框
 */
@property(nonatomic,strong) OSMOMenuPlaceView *leftSecondMenuPlaceView;

/**
 * 右侧一级设置栏弹框
 */
@property(nonatomic,strong) OSMOMenuPlaceView *rightFirstMenuPlaceView;

/**
 * 手动模式出现的菜单
 */
@property(nonatomic,strong) OSMOManualmodeView *osmoMenumodeView;


-(void) refreshViewFrame;

@end
