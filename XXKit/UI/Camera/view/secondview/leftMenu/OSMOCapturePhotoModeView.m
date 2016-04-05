//
//  OSMOCapturePhotoModeView.m
//  XXKit
//
//  Created by tomxiang on 4/5/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOCapturePhotoModeView.h"
#import "OSMOImageLabelButton.h"
#import "XXBase.h"

@interface OSMOCapturePhotoModeView()


@property (strong, nonatomic)  OSMOImageLabelButton *singleButton;      //连拍
@property (strong, nonatomic)  OSMOImageLabelButton *multipleButton;    //单拍
@property (strong, nonatomic)  OSMOImageLabelButton *panoButton;        //全景
@property (strong, nonatomic)  OSMOImageLabelButton *intervalButton;    //定时拍

@end

@implementation OSMOCapturePhotoModeView

-(void) initViews
{
    _singleButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_singleButton setStateIconNormal:@"handle_single_off" iconSelected:@"handle_single_on" text:NSLocalizedString(@"handleSingle",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_singleButton addTarget:self action:@selector(clickSingleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _multipleButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_multipleButton setStateIconNormal:@"handleMultipleOff" iconSelected:@"handleMultipleOn" text:NSLocalizedString(@"handleMultiple",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_multipleButton addTarget:self action:@selector(clickMultipleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _panoButton=[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_panoButton setStateIconNormal:@"handle_mode_pano_off" iconSelected:@"handle_mode_pano_on" text:NSLocalizedString(@"handleSingle",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_panoButton addTarget:self action:@selector(clickPanoButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _intervalButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_intervalButton setStateIconNormal:@"handleIntervalOff" iconSelected:@"handleIntervalOn" text:NSLocalizedString(@"handleSingle",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_intervalButton addTarget:self action:@selector(clickIntervalButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_singleButton];
    [self addSubview:_multipleButton];
    [self addSubview:_panoButton];
    [self addSubview:_intervalButton];
    
    [self reloadSkins];
}

-(void) layoutLandscape
{
    _singleButton.frame     = CGRectMake(0, 0, self.width, OSMOCapturePhotoModeView_HEIGHT);
    _multipleButton.frame    = CGRectMake(0, _singleButton.bottom, self.width, OSMOCapturePhotoModeView_HEIGHT);
    _panoButton.frame   = CGRectMake(0, _multipleButton.bottom, self.width, OSMOCapturePhotoModeView_HEIGHT);
    _intervalButton.frame   = CGRectMake(0, _panoButton.bottom, self.width, OSMOCapturePhotoModeView_HEIGHT);
}

-(void) layoutPortrait
{
    _singleButton.frame     = CGRectMake(0, 0, OSMOCapturePhotoModeView_WIDTH, self.height);
    _multipleButton.frame    = CGRectMake(_singleButton.right,   0, OSMOCapturePhotoModeView_WIDTH, self.height);
    _panoButton.frame   = CGRectMake(_multipleButton.right,  0, OSMOCapturePhotoModeView_WIDTH, self.height);
    _intervalButton.frame   = CGRectMake(_panoButton.right, 0, OSMOCapturePhotoModeView_WIDTH, self.height);
}
@end
