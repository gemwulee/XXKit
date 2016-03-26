//
//  OSMOPhoneView.h
//  XXKit
//
//  Created by tomxiang on 3/23/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectFilterRowBlock)(NSInteger row);

@interface OSMOPhoneView : UIView

@property(nonatomic,strong) NSArray *filterArray;
@property(nonatomic, copy)  SelectFilterRowBlock selectBlock;

@end
