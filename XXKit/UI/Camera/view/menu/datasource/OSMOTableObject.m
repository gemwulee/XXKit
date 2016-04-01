//
//  OSMOTableDataSource.m
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOTableObject.h"

#define TITLEL              @"titleL"
#define LABELR              @"labelR"

#define IMAGEVIEWR          @"imageViewR"
#define SWITCHR             @"swtichR"
#define SHOWRIGHTSIDEIMAGE  @"showRightSideImage"

#define CELLIDENTIFER       @"celldentifier"

@implementation OSMOTableObject

- (instancetype) initWithDic:(NSDictionary*) dic
{
    self = [super init];
    if(self){
        self.celldentifier      = [dic objectForKey:CELLIDENTIFER];
        self.titleL             = [dic objectForKey:TITLEL];

        self.labelR             = [dic objectForKey:LABELR];
        self.imageViewR         = [dic objectForKey:IMAGEVIEWR];
        
        self.swtichR            = [[dic objectForKey:SWITCHR] boolValue];
        self.showRightSideImage = [[dic objectForKey:SHOWRIGHTSIDEIMAGE] boolValue];
    }
    return self;
}


@end
