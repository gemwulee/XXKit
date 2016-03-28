//
//  OSMOCaptureToolView.m
//  Phantom3
//
//  Created by tomxiang on 16/3/25.
//  Copyright (c) 2016年 DJIDevelopers.com. All rights reserved.
//
//

#import "OSMOCaptureToolView.h"
#import "OSMOSwitchView.h"
#import "OSMOModeView.h"
#import "OSMOPhotoVideoView.h"
#import "DJIIPhoneCameraModel.h"
#import "XXBase.h"
#import "DJICameraIPhoneHandler.h"


@interface OSMOCaptureToolView()

@property(nonatomic,strong) OSMOSwitchView            *swtichView;
@property(nonatomic,strong) OSMOModeView              *modeView;
@property(nonatomic,strong) OSMOPhotoVideoView        *photoVideoButton;
@property(nonatomic,strong) UIButton                  *advancedButton;
@property(nonatomic,strong) UIButton                  *playBackButton;
@end


@implementation OSMOCaptureToolView

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model camera:(DJIIPhoneCameraView*) camera
{
    if(self = [super initWithFrame:frame]){
        self.cameraModel = model;
        [self initViewsWithCamera:camera];
    }
    return self;
}

-(void)initViewsWithCamera:(DJIIPhoneCameraView*) camera
{
    _swtichView         = [[OSMOSwitchView alloc] initWithFrame:OSMO_ICON_FRAME];
    _modeView           = [[OSMOModeView alloc] initWithFrame:OSMO_ICON_FRAME withModel:self.cameraModel camera:camera];
    _photoVideoButton   = [[OSMOPhotoVideoView alloc] initWithFrame:OSMO_ICON_FRAME withModel:self.cameraModel camera:camera];
    _advancedButton     = [[UIButton alloc] initWithFrame:OSMO_ICON_FRAME];
    _playBackButton     = [[UIButton alloc] initWithFrame:OSMO_ICON_FRAME];
    
    _swtichView.backgroundColor = [UIColor redColor];
    _modeView.backgroundColor = [UIColor clearColor];
    _photoVideoButton.backgroundColor = [UIColor clearColor];
    _advancedButton.backgroundColor = [UIColor blackColor];
    _playBackButton.backgroundColor = [UIColor grayColor];
    
    
    [self addSubview:_swtichView];
    [self addSubview:_modeView];
    [self addSubview:_photoVideoButton];
    [self addSubview:_advancedButton];
    [self addSubview:_playBackButton];
}

-(void) reloadSkins
{
    if([UIDevice isLandscape]){
        [self layoutLanscape];
    }else{
        [self layoutPortrait];
    }
    
    for(UIView *subView in self.subviews){
        if([subView isKindOfClass:[OSMOView class]] && [subView respondsToSelector:@selector(reloadSkins)]){
            OSMOView *osView = (OSMOView*) subView;
            [osView reloadSkins];
        }
    }
    
}

-(void) layoutLanscape
{
    _modeView.origin           = CGPointMake(0,_swtichView.bottom);
    _photoVideoButton.origin   = CGPointMake(0,_modeView.bottom);
    _advancedButton.origin     = CGPointMake(0,_photoVideoButton.bottom);
    _playBackButton.origin     = CGPointMake(0,_advancedButton.bottom);
    
}

-(void) layoutPortrait
{
    _modeView.origin           = CGPointMake(_swtichView.right, 0);
    _photoVideoButton.origin   = CGPointMake(_modeView.right, 0);
    _advancedButton.origin     = CGPointMake(_photoVideoButton.right, 0);
    _playBackButton.origin     = CGPointMake(_advancedButton.right, 0);
}


@end

