//
//  OSMOStateButton.h
//  XXKit
//
//  Created by tomxiang on 3/30/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OSMOStateButtonState) {
    OSMOStateButtonState_Normal = 0,
    OSMOStateButtonState_Select
};

@interface OSMOStateButton : UIButton

- (void)setStateIconNormal:(NSString*) imageNormal iconSelected:(NSString*) selectImage;


@end
