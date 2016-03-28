//
//  OSMOView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOView.h"
#import "DJIIPhoneCameraViewController.h"

@implementation OSMOView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) reloadSkins
{
    assert(0);
}

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model
{
    assert(0);
}

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model camera:(DJIIPhoneCameraViewController*) camera
{
    if(self = [super initWithFrame:frame]){
        self.cameraModel = model;
        self.camera = camera;
        [self initViews];
    }
    return self;
}

-(void) initViews
{
    assert(0);
}

@end
