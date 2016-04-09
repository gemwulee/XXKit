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

typedef NS_OPTIONS(NSUInteger, OSMOStatusObserveManagerLeftState) {
    OSMOViewManagerState_LEFT_FIRST_CLOSE  = 0,
    OSMOViewManagerState_LEFT_FIRST_OPEN   = 1        //左侧的一级都是处于打开状态
};

typedef NS_OPTIONS(NSUInteger, OSMOStatusObserveManagerRightState) {
    OSMOViewManagerState_RIGHT_FIRST_CLOSE  = 0,
    OSMOViewManagerState_RIGHT_FIRST_OPEN   = 1        //左侧的一级都是处于打开状态

};

typedef NS_OPTIONS(NSUInteger, OSMOStatusObserveManagerTopState) {
    OSMOViewManagerState_TOP_FIRST_CLOSE   = 0,
    OSMOViewManagerState_TOP_FIRST_OPEN    = 1,        //顶部的一级都是处于打开状态
};

@interface OSMOStatusObserveManager : NSObject

-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model
                      camera:(DJIIPhoneCameraViewController*) camera
                      rootVC:(OSMOIPhoneViewController*) rootVC
                      camera:(OSMOEventAction*) cameraAction;

@property(nonatomic,assign) OSMOStatusObserveManagerLeftState managerStateLeft;
@property(nonatomic,assign) OSMOStatusObserveManagerRightState managerStateRight;
@property(nonatomic,assign) OSMOStatusObserveManagerTopState managerStateTop;


@end
