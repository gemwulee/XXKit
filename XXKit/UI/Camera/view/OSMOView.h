//
//  OSMOView.h
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJIIPhoneCameraModel.h"

@protocol OSMOViewAutoRefreshInterface <NSObject>

@required

-(void) reloadSkins;
-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model;


@end

/*
 *  子view必须手动式实现reloadView，里面实现根据mode的刷新机制，否则会崩溃
 */
@interface OSMOView : UIView<OSMOViewAutoRefreshInterface>

@property(nonatomic,strong) DJIIPhoneCameraModel *cameraModel;

@end