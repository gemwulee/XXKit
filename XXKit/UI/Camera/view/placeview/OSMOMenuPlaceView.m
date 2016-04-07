//
//  OSMOMenuPlaceView.m
//  XXKit
//
//  Created by tomxiang on 4/7/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOMenuPlaceView.h"

@implementation OSMOMenuPlaceView

-(void) reloadSkins
{
    for (OSMOView *subView in self.subviews) {
        if([subView isKindOfClass:[OSMOView class]])
        {
            subView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            [subView reloadSkins];
        }
    }
}

-(void) removeSubViews
{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}
-(void) initViews{}
@end
