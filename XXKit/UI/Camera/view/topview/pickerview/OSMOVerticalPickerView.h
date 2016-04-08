//
//  OSMOVerticalPickerView.h
//  XXKit
//
//  Created by tomxiang on 4/7/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOView.h"

#define WHITE_BALANCE_AREA  @"WHITE_BALANCE_AREA"
#define ISO_AREA            @"ISO_AREA"
#define SHUTTER_AREA        @"SHUTTER_AREA"

#define OSMOVerticalPickerViewItemHeight (44.f)
#define OSMOVerticalPickerViewHeight     (44.f*3)

@interface OSMOVerticalPickerView : OSMOView

-(void) setDataSourceArray:(NSArray*) array;

@end
