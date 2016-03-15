//
//  XXMessageModel.h
//  XXKit
//
//  Created by tomxiang on 16/3/10.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXMessageModel : NSObject

@property (nonatomic, copy)   NSString *imageName;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *message;
@property (nonatomic, assign) NSInteger seq;

-(instancetype) initWithModel:(NSString*) imageName name:(NSString*) name message:(NSString*) message seq:(NSInteger) seq;

@end
