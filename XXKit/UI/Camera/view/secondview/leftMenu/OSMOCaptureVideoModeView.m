//
//  OSMOCapturePhotoModeView.m
//  XXKit
//
//  Created by tomxiang on 4/5/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOCaptureVideoModeView.h"
#import "OSMOImageLabelButton.h"
#import "XXBase.h"

@interface OSMOCaptureVideoModeView()

@property (strong, nonatomic)  OSMOImageLabelButton *videoNormalButton;      //录像
@property (strong, nonatomic)  OSMOImageLabelButton *videoHDButton;          //高清录像
@property (strong, nonatomic)  OSMOImageLabelButton *videoSlowButton;        //慢动作
@property (strong, nonatomic)  OSMOImageLabelButton *videoDelayButton;       //延时摄影

@end

@implementation OSMOCaptureVideoModeView

-(void) initViews
{
    _videoNormalButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_videoNormalButton setStateIconNormal:@"handle_mode_video_auto_off" iconSelected:@"handle_mode_video_auto_on" text:NSLocalizedString(@"handleSingle",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_videoNormalButton addTarget:self action:@selector(clickSingleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _videoHDButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_videoHDButton setStateIconNormal:@"handleMultipleOff" iconSelected:@"handleMultipleOn" text:NSLocalizedString(@"handleMultiple",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_videoHDButton addTarget:self action:@selector(clickMultipleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _videoSlowButton=[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_videoSlowButton setStateIconNormal:@"handle_mode_video_slowmotion_off" iconSelected:@"handle_mode_video_slowmotion_on" text:NSLocalizedString(@"handleSingle",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_videoSlowButton addTarget:self action:@selector(clickPanoButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _videoDelayButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_videoDelayButton setStateIconNormal:@"handleIntervalOff" iconSelected:@"handleIntervalOn" text:NSLocalizedString(@"handleSingle",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_videoDelayButton addTarget:self action:@selector(clickIntervalButton:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_videoNormalButton];
    [self addSubview:_videoHDButton];
    [self addSubview:_videoSlowButton];
    [self addSubview:_videoDelayButton];
}

-(void) layoutLandscape
{
    _videoNormalButton.frame     = CGRectMake(0, 0, self.width, OSMOCaptureVideoModeView_HEIGHT);
    _videoHDButton.frame    = CGRectMake(0, _videoNormalButton.bottom, self.width, OSMOCaptureVideoModeView_HEIGHT);
    _videoSlowButton.frame   = CGRectMake(0, _videoHDButton.bottom, self.width, OSMOCaptureVideoModeView_HEIGHT);
    _videoDelayButton.frame   = CGRectMake(0, _videoSlowButton.bottom, self.width, OSMOCaptureVideoModeView_HEIGHT);
}

-(void) layoutPortrait
{
    _videoNormalButton.frame     = CGRectMake(0, 0, OSMOCaptureVideoModeView_WIDTH, self.height);
    _videoHDButton.frame    = CGRectMake(_videoNormalButton.right,   0, OSMOCaptureVideoModeView_WIDTH, self.height);
    _videoSlowButton.frame   = CGRectMake(_videoHDButton.right,  0, OSMOCaptureVideoModeView_WIDTH, self.height);
    _videoDelayButton.frame   = CGRectMake(_videoSlowButton.right, 0, OSMOCaptureVideoModeView_WIDTH, self.height);
}

@end
