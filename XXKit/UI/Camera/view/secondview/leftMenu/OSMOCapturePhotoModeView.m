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
#import "DJIIPhoneCameraModel.h"

@interface OSMOCapturePhotoModeView()


@property (strong, nonatomic)  OSMOImageLabelButton *singleButton;      //连拍
@property (strong, nonatomic)  OSMOImageLabelButton *multipleButton;    //单拍
@property (strong, nonatomic)  OSMOImageLabelButton *panoButton;        //全景
@property (strong, nonatomic)  OSMOImageLabelButton *intervalButton;    //定时拍

@property (strong, nonatomic)  NSMutableArray *arrayButtons;

@end

@implementation OSMOCapturePhotoModeView

-(void) initData{
    _arrayButtons = [NSMutableArray array];
}

-(void) initViews
{
    _singleButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_singleButton setStateIconNormal:@"handle_single_off" iconSelected:@"handle_single_on" text:NSLocalizedString(@"handleSingle",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_singleButton addTarget:self.cameraAction action:@selector(actionClick_SingleButton_PhotoModeView:) forControlEvents:UIControlEventTouchUpInside];
    
    _multipleButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_multipleButton setStateIconNormal:@"handleMultipleOff" iconSelected:@"handleMultipleOn" text:NSLocalizedString(@"handleMultiple",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_multipleButton addTarget:self.cameraAction action:@selector(actionClick_MultipleButton_PhotoModeView:) forControlEvents:UIControlEventTouchUpInside];
    
    _panoButton=[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_panoButton setStateIconNormal:@"handle_mode_pano_off" iconSelected:@"handle_mode_pano_on" text:NSLocalizedString(@"handleSingle",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_panoButton addTarget:self.cameraAction action:@selector(actionClick_PanoButton_PhotoModeView:) forControlEvents:UIControlEventTouchUpInside];
    
    _intervalButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_intervalButton setStateIconNormal:@"handleIntervalOff" iconSelected:@"handleIntervalOn" text:NSLocalizedString(@"handleSingle",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_intervalButton addTarget:self.cameraAction action:@selector(actionClick_IntervalButton_PhotoModeView:) forControlEvents:UIControlEventTouchUpInside];
    
    [_arrayButtons addObject:_singleButton];
    [_arrayButtons addObject:_multipleButton];
    [_arrayButtons addObject:_panoButton];
    [_arrayButtons addObject:_intervalButton];
    
    for(OSMOImageLabelButton *button in _arrayButtons){
        [self addSubview:button];
    }
    
    [self reloadSkins];
}

-(void) layoutLandscape
{
    _singleButton.frame     = CGRectMake(0, 0, self.width, OSMOCapturePhotoModeView_HEIGHT);
    _multipleButton.frame   = CGRectMake(0, _singleButton.bottom, self.width, OSMOCapturePhotoModeView_HEIGHT);
    _panoButton.frame       = CGRectMake(0, _multipleButton.bottom, self.width, OSMOCapturePhotoModeView_HEIGHT);
    _intervalButton.frame   = CGRectMake(0, _panoButton.bottom, self.width, OSMOCapturePhotoModeView_HEIGHT);
}

-(void) layoutPortrait
{
    _singleButton.frame     = CGRectMake(0, 0, OSMOCapturePhotoModeView_WIDTH, self.height);
    _multipleButton.frame   = CGRectMake(_singleButton.right,   0, OSMOCapturePhotoModeView_WIDTH, self.height);
    _panoButton.frame       = CGRectMake(_multipleButton.right,  0, OSMOCapturePhotoModeView_WIDTH, self.height);
    _intervalButton.frame   = CGRectMake(_panoButton.right, 0, OSMOCapturePhotoModeView_WIDTH, self.height);
}

//根据mode刷状态
-(void) setNewStatus
{
    switch (self.cameraModel.photoMode) {
        case DJIIPhone_PhotoSingleMode:{
            [self setButtonSelectedStatus:_singleButton];
        }
            break;
        case DJIIPhone_PhotoContinuousMode:{
            [self setButtonSelectedStatus:_multipleButton];
        }
            break;
        case DJIIPhone_PhotoPanoMode:{
            [self setButtonSelectedStatus:_panoButton];
        }
            break;
        case DJIIPhone_PhotoIntervalMode:{
            [self setButtonSelectedStatus:_intervalButton];
        }
            break;
        default:
            break;
    }
}


-(void) setButtonSelectedStatus : (UIButton*) buttonCurrent
{
    for(OSMOImageLabelButton *button in _arrayButtons){
        if (button != buttonCurrent) {
            button.selected = NO;
        }else{
            button.selected = YES;
        }
    }
}

@end
