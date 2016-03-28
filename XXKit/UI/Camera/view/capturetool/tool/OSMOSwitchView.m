//
//  OSMOSwitchView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOSwitchView.h"
#import "Masonry.h"
#import "DJIIPhoneCameraModel.h"
#import "OSMOCaptureToolView.h"
#import "UIDevice+DJIUIKit.h"


@implementation OSMOSwitchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


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
//    _imageArrow.frame = CGRectMake(OSMOModeView_IMAGE_LANDSCAPE_X, OSMOModeView_IMAGE_LANDSCAPE_Y, OSMOModeView_IMAGE_WIDTH, OSMOModeView_IMAGE_HEIGHT);
}

-(void) layoutPortrait
{
//    _imageArrow.frame = CGRectMake(OSMOModeView_IMAGE_PORTRAIT_X, OSMOModeView_IMAGE_PORTRAIT_Y, OSMOModeView_IMAGE_HEIGHT, OSMOModeView_IMAGE_WIDTH);
}

@end
