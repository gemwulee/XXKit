//
//  OSMOLeftSecondMenuPlaceView.m
//  Phantom3
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import "OSMOLeftSecondMenuPlaceView.h"

@implementation OSMOLeftSecondMenuPlaceView

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

-(void) initViews
{
    
}
@end
