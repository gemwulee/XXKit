//
//  XXTabBarItem.h
//  XXKit
//
//  Created by tomxiang on 16/3/2.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXTabBarItem : UITabBarItem

@property(nonatomic,strong)NSString * normalImageName ;
@property(nonatomic,strong)NSString * hiImageName ;

-(instancetype)initWithTitle:(NSString *)title tag:(NSInteger)tag;

@end
