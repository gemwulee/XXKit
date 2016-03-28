//
//  OSMOModeView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOView.h"
#import "OSMOModeView.h"
#import "Masonry.h"
#import "DJIIPhoneCameraModel.h"
#import "OSMOCaptureToolView.h"
#import "UIDevice+DJIUIKit.h"

@interface OSMOModeView()

@property(nonatomic,strong) UIButton *modeButton;
@property(nonatomic,strong) UIImageView *imageArrow;

@property(nonatomic,weak)   DJIIPhoneCameraView  *delegateHandler;
@end


@implementation OSMOModeView

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
    _modeButton = [[UIButton alloc] init];
    [self addSubview:_modeButton];
    [_modeButton setImage:[UIImage imageNamed:@"handleCameraOff"] forState:UIControlStateNormal];
    [_modeButton setImage:[UIImage imageNamed:@"handleCameraOn"] forState:UIControlStateSelected];
    
    _imageArrow = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageArrow.image = [UIImage imageNamed:@"handleArrowLandscapeOff"];
    _imageArrow.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageArrow];
    
    [_modeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(OSMOModeView_BUTTON_WIDTH, OSMOModeView_BUTTON_HEIGHT));
    }];
    
    [_modeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self reloadSkins];
}

-(void) reloadSkins
{

    
    if([UIDevice isLandscape]){
        [self layoutLandscape];
    }else{
        [self layoutPortrait];
    }
}

-(void) layoutLandscape
{
    _imageArrow.frame = CGRectMake(OSMOModeView_IMAGE_LANDSCAPE_X, OSMOModeView_IMAGE_LANDSCAPE_Y, OSMOModeView_IMAGE_WIDTH, OSMOModeView_IMAGE_HEIGHT);
    if(_modeButton.selected){
        _imageArrow.image = [UIImage imageNamed:@"handleArrowLandscapeOn"];
    }else{
        _imageArrow.image = [UIImage imageNamed:@"handleArrowLandscapeOff"];
    }
}

-(void) layoutPortrait
{
    _imageArrow.frame = CGRectMake(OSMOModeView_IMAGE_PORTRAIT_X, OSMOModeView_IMAGE_PORTRAIT_Y, OSMOModeView_IMAGE_PORTRAIT_WIDTH, OSMOModeView_IMAGE_PORTRAIT_HEIGHT);
    if(_modeButton.selected){
        _imageArrow.image = [UIImage imageNamed:@"handleArrowPotraitOn"];
    }else{
        _imageArrow.image = [UIImage imageNamed:@"handleArrowPotraitOff"];
    }
}

- (void)buttonClick:(UIButton *)button {
    
    button.selected = !button.selected;
    [self reloadSkins];
    
    if(_delegateHandler){}
}

@end
