//
//  OSMOIPhoneHandler.m
//  Phantom3
//
//  Created by tomxiang on 3/25/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import "OSMOIPhoneHandler.h"

@implementation OSMOIPhoneHandler

-(instancetype)init{
    if(self = [super init]){
//        [self startListen];
    }
    return self;
}

     
//网络层 收发包
//-(void)startListen
//{
//    weakSelf(target);
//    [[DJIPackManager sharedInstance] addListenPackClass:[DJIGimbalPushGimbalAttiPack class] forTarget:self withBlock:^(DJIBasePack *recPack) {
//        weakReturn(target);
//        //listen pack
//        GimbalAttiCMDResponseData tmpGimbalData;
//        
//        [recPack getBytes:&tmpGimbalData withLength:sizeof(GimbalAttiCMDResponseData)];
//        //get data
//        [target handleGimblePushData:tmpGimbalData];
//        
//        
//    }];
//}
//-(void)handleGimblePushData:(GimbalAttiCMDResponseData)tmpGimbalData{
//    //
//    tmpGimbalData.rollAngleValue;
//    tmpGimbalData.pitchAngleValue;
//    tmpGimbalData.yawAngleValue;
//}
//
//-(void)sendPack{
//    DJIGimbalTLPControlPack* pack = [[DJIGimbalTLPControlPack alloc] init];
//    //pack.retryTime = 3;    //pack.retryInterval = 0.8;
//    /*
//     set pack content
//     pack.requestBody->motionOrStationary
//     
//     */
//    [[DJIPackManager sharedInstance] sendPack:pack completion:^(DJIBasePack *recPack, DJIPackState state) {
//        if(state == DJIPackStateSuccess){
//            
//        }
//        else{
//            
//        }
//    }];
//}

@end
