//
//  OSMOCaptureModeSelectCell.m
//  XXKit
//
//  Created by tomxiang on 4/5/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOCaptureModeSelectCell.h"
#import "XXBase.h"

#define IMAGEVIEW_WIDTH 70.F
#define IMAGEVIEW_HEIGHT 70.F


@interface OSMOCaptureModeSelectCell()
@property (strong, nonatomic) UIImageView *imageViewC; //中间的图片
@end


@implementation OSMOCaptureModeSelectCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageViewC  = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-IMAGEVIEW_WIDTH)/2, (self.height-IMAGEVIEW_HEIGHT)/2, IMAGEVIEW_WIDTH, IMAGEVIEW_HEIGHT)];
        _imageViewC.backgroundColor = [UIColor redColor];
        _imageViewC.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageViewC];        
    }
    
    return self;
}

-(void) configureData:(NSString*) imageStr
{
    self.imageViewC.image = [UIImage imageNamed:imageStr];
}

@end
