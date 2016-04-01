//
//  OSMODataLoader.h
//  XXKit
//
//  Created by tomxiang on 4/1/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OSMOTableObjectDictPlist @"OSMOTableObjectDict"


@interface OSMODataLoader : NSObject

+(instancetype) sharedInstance;

/**
 *加载OSMOTableObject.plist中的其中一个tableview
 */
-(NSMutableArray*) loadOSMOTableObjectsFromPlist:(NSString*) plistKeyName;

@end
