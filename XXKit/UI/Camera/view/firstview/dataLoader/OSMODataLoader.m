//
//  OSMODataLoader.m
//  XXKit
//
//  Created by tomxiang on 4/1/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMODataLoader.h"
#import "OSMOTableObject.h"
#import "OSMOCaptureModeSelectObject.h"

@implementation OSMODataLoader

+(instancetype) sharedInstance
{
    static OSMODataLoader *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[OSMODataLoader alloc] init];
    });
    
    return instance;
}



-(NSMutableArray*) loadOSMOTableObjectsFromPlist:(NSString*) vcTitle
{
    NSLog(@"start loadOSMO");
    NSString *path = [[NSBundle mainBundle] pathForResource:OSMOTableObjectDictPlist ofType:@"plist"];//@"SettingViewController"
    NSDictionary *dicContentData = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSMutableArray *arrayContent = [dicContentData objectForKey:vcTitle];
    
    NSMutableArray *arrayResult  = [NSMutableArray arrayWithCapacity:arrayContent.count];

    for (int i = 0;i < arrayContent.count; i++) {
        OSMOTableObject *object =[[OSMOTableObject alloc] initWithDic:arrayContent[i]];
        [arrayResult addObject:object];
    }
    NSLog(@"end loadOSMO");

    return arrayResult;
}

-(NSMutableArray*) loadOSMOCaptureModeObjectsFromPlist:(NSString*) vcTitle
{
    NSLog(@"start OSMOCapture");
    NSString *path = [[NSBundle mainBundle] pathForResource:OSMOCaptureModeObjectPlist ofType:@"plist"];//@"SettingViewController"
    NSDictionary *dicContentData = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSMutableArray *arrayContent = [dicContentData objectForKey:vcTitle];
    
    NSMutableArray *arrayResult  = [NSMutableArray arrayWithCapacity:arrayContent.count];
    
    for (int i = 0;i < arrayContent.count; i++) {
        OSMOCaptureModeSelectObject *object =[[OSMOCaptureModeSelectObject alloc] initWithDic:arrayContent[i]];
        [arrayResult addObject:object];
    }
    NSLog(@"end OSMOCapture");
    
    return arrayResult;
}
@end
