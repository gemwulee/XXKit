//
//  OSMOCaptureModeSelectObject.m
//  XXKit
//
//  Created by tomxiang on 4/6/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOCaptureModeSelectObject.h"

#define IMAGEVIEWN          @"imageViewN"
#define IMAGEVIEWS          @"imageViewS"
#define CELLIDENTIFER       @"celldentifier"

@implementation OSMOCaptureModeSelectObject

- (instancetype) initWithDic:(NSDictionary*) dic
{
    self = [super init];
    if(self){
        self.celldentifier = [dic objectForKey:CELLIDENTIFER];
        
        self.imageViewN    = [dic objectForKey:IMAGEVIEWN];
        self.imageViewS    = [dic objectForKey:IMAGEVIEWS];
    }
    return self;
}


@end
