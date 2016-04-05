//
//  OSMOImageLabelButton.h
//  XXKit
//
//  Created by tomxiang on 4/5/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSMOImageLabelButton : UIButton

- (void)setStateIconNormal:(NSString*) imageNormal iconSelected:(NSString*) selectImage
                      text:(NSString*) text
           textNormalColor:(UIColor*)  normalTextColor textSelectedColor:(UIColor*) selectColor;

@end
