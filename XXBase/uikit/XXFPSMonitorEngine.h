//
//  XXFPSMonitorEngine.h
//  XXBase
//
//  Created by tomxiang on 16/2/27.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXFPSMonitorEngine : UIWindow

+(XXFPSMonitorEngine *)sharedInstance;

-(void) startMonistor;
-(void) endMonistor;

@end
