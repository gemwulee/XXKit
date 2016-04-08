//
//  OSMOView.h
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJIIPhoneCameraModel.h"
#import "OSMOEventAction.h"
@class OSMOIPhoneViewController;

@protocol OSMOViewAutoRefreshInterface <NSObject>

@required
//界面三元素
-(void) initData;
-(void) initViews;
-(void) initEvent;

//根据mode刷状态
-(void) layoutLandscape;
-(void) layoutPortrait;
-(void) refreshViewForIPhoneCameraMode;

//恢复默认态
-(void) restoreDefaultStatus;

@optional

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model;

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model camera:(OSMOEventAction*) cameraAction;

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model camera:(OSMOEventAction*) cameraAction plist:(NSString*) plistkey;

@end

/*
 *  子view必须手动式实现reloadView，里面实现根据mode的刷新机制，否则会崩溃
 */
@interface OSMOView : UIView<OSMOViewAutoRefreshInterface>

@property(nonatomic,weak)   DJIIPhoneCameraModel  *cameraModel;
@property(nonatomic,weak)   OSMOEventAction       *cameraAction;
@property(nonatomic,weak)   OSMOIPhoneViewController *rootCameraVC;

-(void) reloadSkins;
-(void) removeOSMOSubViews;
-(void) reloadSkinsSize;

@end
