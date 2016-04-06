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
#import "OSMOCapturePhotoModeView.h"


@interface OSMOCaptureVideoModeView()

@property (strong, nonatomic)  OSMOImageLabelButton *videoNormalButton;      //录像
@property (strong, nonatomic)  OSMOImageLabelButton *videoHDButton;          //高清录像
@property (strong, nonatomic)  OSMOImageLabelButton *videoSlowButton;        //慢动作
@property (strong, nonatomic)  OSMOImageLabelButton *videoDelayButton;       //延时摄影
@property (strong, nonatomic)  NSMutableArray *arrayButtons;
@end

@implementation OSMOCaptureVideoModeView

-(void) initData{
    _arrayButtons = [NSMutableArray array];
}

-(void) initViews
{
    _videoNormalButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_videoNormalButton setStateIconNormal:@"handle_mode_video_auto_off" iconSelected:@"handle_mode_video_auto_on" text:NSLocalizedString(@"handleSingle",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_videoNormalButton addTarget:self.cameraAction action:@selector(actionClick_VideoNormalButton_VideoModeView:) forControlEvents:UIControlEventTouchUpInside];
    
    _videoHDButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_videoHDButton setStateIconNormal:@"handle_mode_video_4K_off" iconSelected:@"handle_mode_video_4K_on" text:NSLocalizedString(@"handleMultiple",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_videoHDButton addTarget:self.cameraAction action:@selector(actionClick_VideoHDButton_VideoModeView:) forControlEvents:UIControlEventTouchUpInside];
    
    _videoSlowButton=[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_videoSlowButton setStateIconNormal:@"handle_mode_video_slowmotion_off" iconSelected:@"handle_mode_video_slowmotion_on" text:NSLocalizedString(@"handleSingle",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_videoSlowButton addTarget:self.cameraAction action:@selector(actionClick_VideoSlowButton_VideoModeView:) forControlEvents:UIControlEventTouchUpInside];
    
    _videoDelayButton =[[OSMOImageLabelButton alloc] initWithFrame:CGRectZero];
    [_videoDelayButton setStateIconNormal:@"handle_mode_video_timelapse_off" iconSelected:@"handle_mode_video_timelapse_on" text:NSLocalizedString(@"handle_mode_video_timelapse",nil) textNormalColor:[UIColor whiteColor] textSelectedColor:[UIColor colorWithR:0 G:200 B:255 A:1]];
    [_videoDelayButton addTarget:self.cameraAction action:@selector(actionClick_VideoDelayButton_VideoModeView:) forControlEvents:UIControlEventTouchUpInside];

    [_arrayButtons addObject:_videoNormalButton];
    [_arrayButtons addObject:_videoHDButton];
    [_arrayButtons addObject:_videoSlowButton];
    [_arrayButtons addObject:_videoDelayButton];
    
    for(OSMOImageLabelButton *button in _arrayButtons){
        [self addSubview:button];
    }
    
    [self reloadSkins];
}

-(void) layoutLandscape
{
    _videoNormalButton.frame     = CGRectMake(0, 0, self.width, OSMOCapturePhotoModeView_HEIGHT);
    _videoHDButton.frame         = CGRectMake(0, _videoNormalButton.bottom, self.width, OSMOCapturePhotoModeView_HEIGHT);
    _videoSlowButton.frame       = CGRectMake(0, _videoHDButton.bottom, self.width, OSMOCapturePhotoModeView_HEIGHT);
    _videoDelayButton.frame      = CGRectMake(0, _videoSlowButton.bottom, self.width, OSMOCapturePhotoModeView_HEIGHT);
}

-(void) layoutPortrait
{
    _videoNormalButton.frame     = CGRectMake(0, 0, OSMOCapturePhotoModeView_WIDTH, self.height);
    _videoHDButton.frame         = CGRectMake(_videoNormalButton.right, 0, OSMOCapturePhotoModeView_WIDTH, self.height);
    _videoSlowButton.frame       = CGRectMake(_videoHDButton.right, 0, OSMOCapturePhotoModeView_WIDTH, self.height);
    _videoDelayButton.frame      = CGRectMake(_videoSlowButton.right, 0, OSMOCapturePhotoModeView_WIDTH, self.height);
}

//根据mode刷状态
-(void) setNewStatus
{
    switch (self.cameraModel.videoMode) {
        case DJIIPhone_VideoAutoMode:{
            [self setButtonSelectedStatus:_videoNormalButton];
        }
            break;
        case DJIIPhone_4KVideoMode:{
            [self setButtonSelectedStatus:_videoHDButton];
        }
            break;
        case DJIIPhone_SlowVideoMode:{
            [self setButtonSelectedStatus:_videoSlowButton];
        }
            break;
        case DJIIPhone_DelayVideoMode:{
            [self setButtonSelectedStatus:_videoDelayButton];
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
