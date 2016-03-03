//
//  XXFPSEngine.h
//  XXBase
//
//  Created by tomxiang on 16/2/27.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXFPSEngine : UIWindow

+(XXFPSEngine *)sharedInstance;

-(void) startMonistor;
-(void) endMonistor;

@end
