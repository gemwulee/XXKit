//
//  OSMOStateButton.m
//  XXKit
//
//  Created by tomxiang on 3/30/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOStateButton.h"

@implementation OSMOStateButton

-(instancetype)init
{
    if(self = [super init]){
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonClick:(UIButton *)button {
    self.selected = !self.selected;
}


- (void)setStateIconNormal:(NSString*) imageNormal iconSelected:(NSString*) selectImage
{
    [self setImage:[UIImage imageNamed:imageNormal] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:selectImage] forState: UIControlStateSelected];
}

@end
