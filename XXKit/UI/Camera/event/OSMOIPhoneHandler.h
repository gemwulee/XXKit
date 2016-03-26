//
//  OSMOIPhoneHandler.h
//  Phantom3
//
//  Created by tomxiang on 3/25/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)();
typedef void (^FailedBlock)();

@interface OSMOIPhoneHandler : NSObject

//TimeLapse的内容用Listener去监听,然后起作用
-(void)sendTimeLapsePack:(SuccessBlock) successBlock failedBlock:(FailedBlock) failedBlock;


//发送Gimbal快慢控制的包
//valueData = 3 ; Fast
//valueData = 4 ; Medium:
//valueData = 5 ; Slow
//valueData = 0 ; C1
//valueData = 1 ; C2
-(void) sendModelPack:(uint8_t) valueData successBlock:(SuccessBlock) successblock failedBlock:(FailedBlock) failedBlock;

@end
