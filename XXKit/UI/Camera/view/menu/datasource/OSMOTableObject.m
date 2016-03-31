//
//  OSMOTableDataSource.m
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOTableObject.h"

@implementation OSMOTableObject

+ (NSString*) getOSMOCameraTitle
{
    return @"相机";
}

- (instancetype) initWithDic:(NSDictionary*) dic
{
    self = [super init];
    if(self){
        self.titleL = [dic objectForKey:OSMO_MENU_CELL_LABEL_L];

        self.labelR     = [dic objectForKey:OSMO_MENU_CELL_LABEL_R];
        self.imageViewR = [dic objectForKey:OSMO_MENU_CELL_IMAGE_R];
        
        self.swtichR    = [[dic objectForKey:OSMO_MENU_CELL_SWITCH_R] boolValue];
        self.showRightSideImage = [[dic objectForKey:OSMO_MENU_CELL_IMAGE_INDICATOR] boolValue];
    }
    return self;
}


@end
