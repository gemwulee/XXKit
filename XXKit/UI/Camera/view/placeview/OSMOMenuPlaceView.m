//
//  OSMOMenuPlaceView.m
//  XXKit
//
//  Created by tomxiang on 4/7/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOMenuPlaceView.h"

@implementation OSMOMenuPlaceView

-(void) initData{}
-(void) initViews{}
-(void) initEvent{}

//根据mode刷状态
-(void) layoutLandscape{}
-(void) layoutPortrait{}

-(void) refreshViewForIPhoneCameraMode{
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:[OSMOView class]]){
            [(OSMOView*)subView refreshViewForIPhoneCameraMode];
        }
    }
}

-(void) restoreDefaultStatus{}

@end
 