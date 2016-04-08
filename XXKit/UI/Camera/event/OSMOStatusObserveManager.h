//
//  OSMOStatusObserveManager.h
//  XXKit
//
//  Created by tomxiang on 4/8/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSMOView;
@class DJIIPhoneCameraViewController;
@class OSMOIPhoneViewController;
@class DJIIPhoneCameraModel;
@class OSMOEventAction;

//控制OSMOView状态的状态机，原则是left_first 管理整个左侧。right_first管理整个右侧等。以此类推
//最终情况是左右不互斥，顶部状态跟 左／右 互斥

typedef NS_OPTIONS(NSUInteger, OSMOStatusObserveManagerState) {
    OSMOViewManagerState_None              = 0,
    OSMOViewManagerState_LEFT_FIRST_OPEN   = 1 << 1,        //左侧的一级都是处于打开状态
    OSMOViewManagerState_LEFT_FIRST_CLOSE  = 1 << 2,
    OSMOViewManagerState_RIGHT_FIRST_OPEN  = 1 << 3,        //右侧的一级都是处于打开状态
    OSMOViewManagerState_RIGHT_FIRST_CLOSE = 1 << 4,
    OSMOViewManagerState_TOP_FIRST_OPEN    = 1 << 5,        //顶部的一级都是处于打开状态
    OSMOViewManagerState_TOP_FIRST_CLOSE   = 1 << 6,
};

@interface OSMOStatusObserveManager : NSObject

-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model
                      camera:(DJIIPhoneCameraViewController*) camera
                      rootVC:(OSMOIPhoneViewController*) rootVC
                      camera:(OSMOEventAction*) cameraAction;

@property(nonatomic,assign) OSMOStatusObserveManagerState managerState;

@end
