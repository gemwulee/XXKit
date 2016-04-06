//
//  OSMOSwitch.m
//  XXKit
//
//  Created by tomxiang on 4/6/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOSwitch.h"

@implementation OSMOSwitch


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.transform = CGAffineTransformMakeScale( .75, .75);
//    self.onTintColor = [UIColor greenColor]; // 在oneSwitch开启的状态显示的颜色 默认是blueColor

}


@end
