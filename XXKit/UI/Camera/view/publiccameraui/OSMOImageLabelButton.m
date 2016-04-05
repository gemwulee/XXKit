//
//  OSMOImageLabelButton.m
//  XXKit
//
//  Created by tomxiang on 4/5/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOImageLabelButton.h"
#define SPACING 5.F

@implementation OSMOImageLabelButton

-(instancetype)init
{
    if(self = [super init]){
//        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self verticalImageAndTitle:SPACING];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
//        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self verticalImageAndTitle:SPACING];
    }
    return self;
}

//- (void)buttonClick:(UIButton *)button {
//    self.selected = !self.selected;
//}

- (void)setStateIconNormal:(NSString*) imageNormal iconSelected:(NSString*) selectImage
                      text:(NSString*) text
           textNormalColor:(UIColor*)  normalTextColor textSelectedColor:(UIColor*) selectColor
{
    [self setImage:[UIImage imageNamed:imageNormal] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:selectImage] forState: UIControlStateSelected];
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitleColor:normalTextColor forState:UIControlStateNormal];
    [self setTitleColor:selectColor forState:UIControlStateSelected];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat midX = self.frame.size.width / 2;
    CGFloat midY = self.frame.size.height/ 2 ;
    self.titleLabel.center = CGPointMake(midX, midY + 20);
    self.imageView.center = CGPointMake(midX, midY - 10);
    
}
//
//- (void)verticalImageAndTitle:(CGFloat)spacing
//{
//    self.titleLabel.backgroundColor = [UIColor greenColor];
//    CGSize imageSize = self.imageView.frame.size;
//    CGSize titleSize = self.titleLabel.frame.size;
//    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
//    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
//    if (titleSize.width + 0.5 < frameSize.width) {
//        titleSize.width = frameSize.width;
//    }
//    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
//    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
//    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
//    
//}

@end
