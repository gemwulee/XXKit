//
//  XXMessageModel.m
//  XXKit
//
//  Created by tomxiang on 16/3/10.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "XXMessageModel.h"

@implementation XXMessageModel

-(instancetype) initWithModel:(NSString*) imageName name:(NSString*) name message:(NSString*) message seq:(NSInteger) seq
{
    if (self = [super init]) {
        self.imageName = imageName;
        self.name = name;
        self.message = message;
        self.seq = seq;
        
    }
    return self;
}

@end
