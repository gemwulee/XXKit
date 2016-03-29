//
//  OSMOSwitchView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOSwitchView.h"
#import "Masonry.h"
#import "DJIIPhoneCameraModel.h"
#import "OSMOCaptureToolView.h"
#import "UIDevice+DJIUIKit.h"
#import "UIView+Common.h"
#import "OSMOCaptureToolView.h"

@interface OSMOSwitchView()
@property(nonatomic,strong) UIImageView *imageViewBg;    //灰色背景
@property(nonatomic,strong) UIImageView *imageViewPhoto;
@property(nonatomic,strong) UIImageView *imageViewVideo;

@property(nonatomic,strong) UIImageView *imageSwitchOn;  //Switch开关,小圆按钮

@property(nonatomic,strong) UIButton *buttonPhoto;       //clear,为了增大点击区域
@property(nonatomic,strong) UIButton *buttonVideo;
@end


@implementation OSMOSwitchView

-(void)initViews
{
    _imageViewBg = [[UIImageView alloc] init];
    _imageViewPhoto = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:@"handleCamModeOn"]];
    _imageViewVideo = [[UIImageView alloc] init];//WithImage:@"handleVideoModeOff"]];
    _imageSwitchOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"handleSwitchIcon"]];
    
    [self addSubview:_imageViewBg];

    [_imageViewBg addSubview:_imageSwitchOn];
    [_imageViewBg addSubview:_imageViewPhoto];
    [_imageViewBg addSubview:_imageViewVideo];
    
    _imageViewPhoto.contentMode = UIViewContentModeScaleAspectFill;
    _imageViewVideo.contentMode = UIViewContentModeScaleAspectFill;
    
    _imageViewVideo.size = _imageViewPhoto.size = (CGSizeMake(OSMOSwitchView_PHOTO_IMAGE_WIDTH, OSMOSwitchView_PHOTO_IMAGE_HEIGHT));

    _buttonPhoto = [[UIButton alloc] initWithFrame:CGRectZero];
    _buttonVideo = [[UIButton alloc] initWithFrame:CGRectZero];
    
    [self addSubview:_buttonPhoto];
    [self addSubview:_buttonVideo];
    
    [self reloadSkins];
}

-(void) reloadSkins
{
    switch (self.cameraModel.captureMode) {
        case DJIIPhone_PhotoModel:
        {
            _imageViewPhoto.image = [UIImage imageNamed:@"handleCamModeOn"];
            _imageViewVideo.image = [UIImage imageNamed:@"handleVideoModeOff"];
        }
            break;
        case DJIIPhone_VideoModel:
        {
            _imageViewPhoto.image = [UIImage imageNamed:@"handleCamModeOff"];
            _imageViewVideo.image = [UIImage imageNamed:@"handleVideoModeOn"];
        }
            break;
        default:
            break;
    }
    
    
    if([UIDevice isLandscape]){
        [self layoutLandscape];
    }else{
        [self layoutPortrait];
    }
}

-(void) layoutLandscape
{
    [_buttonPhoto setFrame:CGRectMake(0, 0, self.width,self.height/2)];
    [_buttonVideo setFrame:CGRectMake(0, _buttonVideo.right, self.width, self.height/2)];

    _imageViewBg.image = [UIImage imageNamed:@"handleLandscapeSwitchBg"];
    [_imageViewBg setFrame:CGRectMake(OSMOSwitchView_Y, 0, self.width/2, self.height)];
    
    [_imageSwitchOn setFrame:CGRectMake(0, 0, _imageViewBg.width, _imageViewBg.height/2)];
    [_imageViewPhoto setOrigin:CGPointMake((_imageViewBg.width - OSMOSwitchView_PHOTO_IMAGE_WIDTH)/2,OSMOSwitchView_ImageViewPhoto_Landscape_Y)];
    [_imageViewVideo setOrigin:CGPointMake(_imageViewPhoto.x, OSMOSwitchView_ImageViewVideo_Landscape_Y)];
}

-(void) layoutPortrait
{
    [_buttonPhoto setFrame:CGRectMake(0, 0, self.width/2,self.height)];
    [_buttonVideo setFrame:CGRectMake(0, _buttonVideo.right, self.width/2, self.height)];

    _imageViewBg.image = [UIImage imageNamed:@"handlePotraitSwitchBg"];
    [_imageViewBg setFrame:CGRectMake(0, OSMOSwitchView_Y, self.width, (self.height-OSMOSwitchView_Y*2))];
    
    [_imageSwitchOn setFrame:CGRectMake(0, 0, _imageViewBg.width/2, _imageViewBg.height)];
    [_imageViewPhoto setOrigin:CGPointMake(OSMOSwitchView_ImageViewPhoto_Portrait_Y, (_imageViewBg.height - OSMOSwitchView_PHOTO_IMAGE_HEIGHT)/2)];
    [_imageViewVideo setOrigin:CGPointMake(OSMOSwitchView_ImageViewVideo_Portrait_Y, _imageViewPhoto.y)];

}

@end
