//
//  OSMOCaptureToolView.h
//  Phantom3
//
//  Created by tomxiang on 16/3/25.
//  Copyright (c) 2016年 DJIDevelopers.com. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface OSMOCaptureToolView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *camModePotraitArrowIcon;

@property (weak, nonatomic) IBOutlet UIImageView *camModeLandscapeArrowIcon;
@property (weak, nonatomic) IBOutlet UIImageView *camModeRightLandscapeArrowIcon;

@property (weak, nonatomic) IBOutlet UIView *cameraModeView;

@property (weak, nonatomic) IBOutlet UIView *captureBtnView;

@property (weak, nonatomic) IBOutlet UIView *psmaView;

@property (weak, nonatomic) IBOutlet UIView *playbackView;

/**
 *  29:50 stop counter
 */
@property (weak, nonatomic) IBOutlet UILabel *halfHourCounter;






@end
