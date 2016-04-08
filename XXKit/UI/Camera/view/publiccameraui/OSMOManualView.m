//
//  OSMOManualView.m
//  XXKit
//
//  Created by tomxiang on 4/7/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOManualView.h"
#import "Masonry.h"

@interface OSMOManualView()

@property(nonatomic,strong) UILabel *labelTip;
@property(nonatomic,strong) UILabel *labelContent;

@end

@implementation OSMOManualView

- (instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initViews];
    }
    return self;
}

- (void)initViews{
    _labelTip = [[UILabel alloc] initWithFrame:CGRectZero];
    _labelTip.font = [UIFont systemFontOfSize:16.f];
    _labelTip.textColor = [UIColor whiteColor];
    _labelTip.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_labelTip];
    
    _labelContent = [[UILabel alloc] initWithFrame:CGRectZero];
    _labelContent.font = [UIFont systemFontOfSize:20.f];
    _labelContent.textColor = [UIColor whiteColor];
    _labelContent.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_labelContent];

    [_labelTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self);
        make.centerY.equalTo(self);
        make.left.mas_equalTo(self.mas_left).with.offset(0);
    }];
    
    [_labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(_labelTip);
        make.left.mas_equalTo(_labelTip.mas_right).with.offset(5);
    }];
}

-(void) setLabelTipText:(NSString*) labelTip
{
    self.labelTip.text     = labelTip;
    [self.labelTip sizeToFit];
    [self setNeedsLayout];
}

-(void) setLabelContentText:(NSString *)labelContent
{
    self.labelContent.text = labelContent;
    [self.labelContent sizeToFit];
    [self setNeedsLayout];
}

@end
