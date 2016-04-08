//
//  OSMOView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOView.h"
#import "UIDevice+DJIUIKit.h"
#import "OSMOIPhoneViewController.h"

@implementation OSMOView

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model{
    assert(0);
}

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model camera:(OSMOEventAction*) cameraAction
{
    if(self = [super initWithFrame:frame]){
        self.cameraModel = model;
        self.cameraAction = cameraAction;
        [self initData];
        [self initViews];
        [self initEvent];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model camera:(OSMOEventAction*) cameraAction plist:(NSString*) plistkey
{ assert(0);}

-(void) reloadSkins{
    
    if([UIDevice isLandscape]){
        [self layoutLandscape];
    }else{
        [self layoutPortrait];
    }
    [self refreshViewForIPhoneCameraMode];

    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:[OSMOView class]])
        {
            OSMOView *osView = (OSMOView*) subView;
//            subView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            [osView reloadSkins];
        }
    }
}

-(void) reloadSkinsSize
{
    if([UIDevice isLandscape]){
        [self layoutLandscape];
    }else{
        [self layoutPortrait];
    }
    [self refreshViewForIPhoneCameraMode];
    
    for (UIView *subView in self.subviews) {
        if([subView isKindOfClass:[OSMOView class]])
        {
            OSMOView *osView = (OSMOView*) subView;
            subView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            [osView reloadSkins];
        }
    }
}

-(void) removeOSMOSubViews
{
    for (OSMOView *subView in self.subviews) {
        if([subView isKindOfClass:[OSMOView class]]){
            [subView removeFromSuperview];
        }
    }
}



-(void) initData
{ assert(0);}
-(void) initViews
{ assert(0);}
-(void) initEvent
{ assert(0);}

-(void) layoutLandscape
{ assert(0);}
-(void) layoutPortrait
{ assert(0);}
//根据mode刷状态
-(void) refreshViewForIPhoneCameraMode
{ assert(0);}
//恢复默认态
-(void) restoreDefaultStatus
{ assert(0);}


@end
