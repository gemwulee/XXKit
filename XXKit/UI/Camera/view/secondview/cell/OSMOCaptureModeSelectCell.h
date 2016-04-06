//
//  OSMOCaptureModeSelectCell.h
//  XXKit
//
//  Created by tomxiang on 4/5/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OSMOPhotoSingleModeIdentifier  @"OSMOPhotoSingleModeIdentifier"
#define OSMOPhotoPanoModeIdentifier    @"OSMOPhotoPanoModeIdentifier"

@class OSMOCaptureModeSelectObject;


@interface OSMOCaptureModeSelectCell : UICollectionViewCell

-(void) configureData:(OSMOCaptureModeSelectObject*) modeSelectObject;

@end
