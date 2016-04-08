//
//  OSMOVerticalPickerViewCell.m
//  XXKit
//
//  Created by tomxiang on 4/7/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOVerticalPickerViewCell.h"
#import <Foundation/Foundation.h>
@interface OSMOVerticalPickerViewCell()
@property(nonatomic,strong) UILabel *labelTitle;
@end

@implementation OSMOVerticalPickerViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _labelTitle = [[UILabel alloc] initWithFrame:self.bounds];
        _labelTitle.backgroundColor = [UIColor whiteColor];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.font = [UIFont systemFontOfSize:14.f];
        [self.contentView addSubview:_labelTitle];
    }
    
    return self;
}
-(void) configureData:(NSNumber*) text
{
    NSString *myString = [text stringValue];
    self.labelTitle.text = myString;
}

@end
