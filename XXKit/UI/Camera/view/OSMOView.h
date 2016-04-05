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

-(void) reloadSkins;

-(void) initViews;

@optional

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model;

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model camera:(OSMOEventAction*) cameraAction;

//-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model camera:(OSMOEventAction*) cameraAction rootVC:(OSMOIPhoneViewController*) rootCameraVC;


@end

/*
 *  子view必须手动式实现reloadView，里面实现根据mode的刷新机制，否则会崩溃
 */
@interface OSMOView : UIView<OSMOViewAutoRefreshInterface>

@property(nonatomic,weak)   DJIIPhoneCameraModel  *cameraModel;
@property(nonatomic,weak)   OSMOEventAction       *cameraAction;
@property(nonatomic,weak)   OSMOIPhoneViewController *rootCameraVC;

-(void) reloadSkins;

-(void) layoutLandscape;
-(void) layoutPortrait;

//根据mode刷状态
-(void) setNewStatus;

//恢复默认态
-(void) setDefaultStatus;
@end
