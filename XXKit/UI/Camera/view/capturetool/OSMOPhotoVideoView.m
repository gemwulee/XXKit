//
//  OSMOPhotoVideoView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOPhotoVideoView.h"
#import "Masonry.h"
#import "DJIIPhoneCameraModel.h"
#import "DJIIPhoneCameraView.h"

@interface OSMOPhotoVideoView()
@property(nonatomic,strong) UIImageView *imageViewBg;
@property(nonatomic,strong) UIImageView *imageViewSaving;
@property(nonatomic,strong) UIButton    *buttonCapture;

@property(nonatomic,weak)   DJIIPhoneCameraView       *delegateHandler;

@end

@implementation OSMOPhotoVideoView

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model camera:(DJIIPhoneCameraView*) camera
{
    if(self = [super initWithFrame:frame]){
        self.cameraModel = model;
        self.delegateHandler = camera;
        [self initViews];
    }
    return self;
}

-(void) initViews
{
    _imageViewBg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_imageViewBg];

    _imageViewSaving = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_imageViewSaving];

    _buttonCapture = [[UIButton alloc] init];
     [self addSubview:_buttonCapture];
    _buttonCapture.backgroundColor = [UIColor clearColor];
    
    
    [_imageViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(OSMOPhotoVideoView_IMAGE_WIDTH, OSMOPhotoVideoView_IMAGE_HEIGHT));
    }];
    
    [_imageViewSaving mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(OSMOPhotoVideoView_IMAGE_WIDTH, OSMOPhotoVideoView_IMAGE_HEIGHT));
    }];
    
    [_buttonCapture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(OSMOPhotoVideoView_BUTTON_WIDTH, OSMOPhotoVideoView_BUTTON_HEIGHT));
    }];
    _buttonCapture.userInteractionEnabled = YES;
    if(_delegateHandler){
        [_buttonCapture addTarget:_delegateHandler action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];

    }else{
        assert(0);
    }
    
    [self reloadSkins];
}

-(void) reloadSkins
{
    switch(self.cameraModel.captureMode){
            
        case DJIIPhone_PhotoModel:
        {
            _imageViewBg.image = [UIImage imageNamed:@"handle_camera_tool_bg"];
            _imageViewSaving.image = [UIImage imageNamed:@"handle_camera_tool_saving"];
            [_buttonCapture setImage:[UIImage imageNamed:@"handle_camera_tool_photo"] forState:UIControlStateNormal];
        }
            break;
        case DJIIPhone_VideoModel:
        {
            _imageViewBg.image = [UIImage imageNamed:@"handle_camera_tool_bg"];
            _imageViewSaving.image = [UIImage imageNamed:@"handle_camera_tool_saving"];
            [_buttonCapture setImage:[UIImage imageNamed:@"handle_camera_tool_video"] forState:UIControlStateNormal];
        }
            break;
    }

}

@end
