//
//  OSMOCaptureModeSelectCell.m
//  XXKit
//
//  Created by tomxiang on 4/5/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOCaptureModeSelectCell.h"
#import "XXBase.h"
#import "OSMOCaptureModeSelectObject.h"
#import "OSMOStateButton.h"

#define IMAGEVIEW_WIDTH  70.F
#define IMAGEVIEW_HEIGHT 70.F


@interface OSMOCaptureModeSelectCell()
@property(nonatomic,strong) OSMOStateButton *captureModeButton;
@end


@implementation OSMOCaptureModeSelectCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        _captureModeButton = [[OSMOStateButton alloc] initWithFrame:self.bounds];
        _captureModeButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_captureModeButton];
        [_captureModeButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void) setButtonSelected:(BOOL) isSelected{
    _captureModeButton.selected = isSelected;
}

-(void) onButtonClick:(id) sender{
    weakSelf(target);
    if (target.clickButtonAction) {
        weakReturn(target);
        target.clickButtonAction(target,sender);
    }
}

-(void) configureData:(OSMOCaptureModeSelectObject*) modeSelectObject{
    [_captureModeButton setStateIconNormal:modeSelectObject.imageViewN iconSelected:modeSelectObject.imageViewS];
}

@end
