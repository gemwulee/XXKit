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
#define BUTTONTEXTN         @"buttonTextN"

@implementation OSMOCaptureModeSelectObject

- (instancetype) initWithDic:(NSDictionary*) dic
{
    self = [super init];
    if(self){
        self.celldentifier = [dic objectForKey:CELLIDENTIFER];
        
        self.imageViewN    = [dic objectForKey:IMAGEVIEWN];
        self.imageViewS    = [dic objectForKey:IMAGEVIEWS];
        self.buttonTextN   = [dic objectForKey:BUTTONTEXTN];
    }
    return self;
}


@end
