//
//  OSMOIPhoneHandler.m
//  Phantom3
//
//  Created by tomxiang on 3/25/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import "OSMOIPhoneHandler.h"
//#import "DJIGimbalLogic.h"
//
//@interface OSMOIPhoneHandler()
//@property (assign,nonatomic) GimbalAttiCMDResponseData *currentGimbalState;
//@end

@implementation OSMOIPhoneHandler

//-(instancetype)init{
//    if(self = [super init]){
//        [self startListen];
//    }
//    return self;
//}
//
//
////网络层 收发包
//-(void)startListen
//{
//    weakSelf(target);
//    [[DJIPackManager sharedInstance] addListenPackClass:[DJIGimbalPushGimbalAttiPack class] forTarget:self withBlock:^(DJIBasePack *recPack) {
//        weakReturn(target);
//        weakReturn(target);
//        SAFE_ALLOC(target.currentGimbalState);
//        
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
//    if(memcmp(&_currentGimbalState, &tmpGimbalData, sizeof(GimbalAttiCMDResponseData))!=0){
//        memcpy(&_currentGimbalState, &tmpGimbalData, sizeof(GimbalAttiCMDResponseData));//save the latest
//    }
//}
//
//-(void)sendTimeLapsePack:(SuccessBlock) successBlock failedBlock:(FailedBlock) failedBlock{
//    if (!_currentGimbalState) {
//        return;
//    }
//    DJIGimbalTLPControlPack* pack = [[DJIGimbalTLPControlPack alloc] initRequest];
//    pack.retryTime = 3;
//    pack.retryInterval = 0.8;
//    
//    gimbalTLPControlData *body = malloc(sizeof(gimbalTLPControlData) + sizeof(gimbalTLPParam) * 3);
//    pack.requestBody = body;
//    pack.body = body;
//    
//    //     set pack content
//    pack.requestBody->motionOrStationary = 0;
//    pack.requestBody->tripod = 0;
//    pack.requestBody->startStop = 1;
//    
//    pack.requestBody->tlpParam[0].duration = 1.f;
//    pack.requestBody->tlpParam[0].yaw = _currentGimbalState->yawAngleValue;
//    pack.requestBody->tlpParam[0].pitch = _currentGimbalState->pitchAngleValue;
//    pack.requestBody->tlpParam[0].roll = _currentGimbalState->rollAngleValue;
//    
//    pack.requestBody->tlpParam[1].duration = 2.f;
//    pack.requestBody->tlpParam[1].yaw = _currentGimbalState->yawAngleValue +1;
//    pack.requestBody->tlpParam[1].pitch = _currentGimbalState->pitchAngleValue+1;
//    pack.requestBody->tlpParam[1].roll = _currentGimbalState->rollAngleValue+2;
//    
//    pack.requestBody->tlpParam[2].duration = 2.f;
//    pack.requestBody->tlpParam[2].yaw = _currentGimbalState->yawAngleValue+2;
//    pack.requestBody->tlpParam[2].pitch = _currentGimbalState->pitchAngleValue+2;
//    pack.requestBody->tlpParam[2].roll = _currentGimbalState->rollAngleValue+2;
//    
//    pack.bodyLength = sizeof(gimbalTLPControlData) + sizeof(gimbalTLPParam) * 3;
//    
//    [[DJIPackManager sharedInstance] sendPack:pack completion:^(DJIBasePack *recPack, DJIPackState state) {
//        if(state == DJIPackStateSuccess){
//            successBlock();
//        }
//        else{
//            failedBlock();
//        }
//    }];
//}
//
//- (void) sendModelPack:(uint8_t) valueData successBlock:(SuccessBlock) successblock failedBlock:(FailedBlock) failedBlock{
//    [[DJIGimbalLogic sharedInstance]setUserConfigWithValue:valueData id:0 length:1 callBack:^(BOOL isSuccess){
//        if (isSuccess) {
//            successblock();
//        }else{
//            failedBlock();
//        }
//    }] ;
//}

@end
