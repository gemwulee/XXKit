//
//  OSMORightFirstMenuPlaceView.m
//  Phantom3
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import "OSMORightFirstMenuPlaceView.h"
#import "XXBase.h"
#import "OSMOMenuController.h"
#import "OSMOIPhoneViewController.h"

@implementation OSMORightFirstMenuPlaceView

-(void) reloadSkins
{
    if([UIDevice isLandscape]){
        [self layoutLandscape];
    }else{
        [self layoutPortrait];
    }
}

-(void) initViews
{
    
}

-(void) layoutLandscape
{
}

-(void) layoutPortrait
{
   
}



@end
