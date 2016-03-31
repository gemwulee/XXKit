//
//  OSMOView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOView.h"
#import "UIDevice+DJIUIKit.h"

@implementation OSMOView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model
{
    assert(0);
}

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model camera:(OSMOEventAction*) cameraAction
{
    if(self = [super initWithFrame:frame]){
        self.cameraModel = model;
        self.cameraAction = cameraAction;
        [self initData];
        [self initViews];
    }
    return self;
}

-(void) initData
{}


-(void) initViews
{
    assert(0);
}

-(void) reloadSkins
{
    if([UIDevice isLandscape]){
        [self layoutLandscape];
    }else{
        [self layoutPortrait];
    }
}

-(void) layoutLandscape
{
}

-(void) layoutPortrait
{
    
}

@end
