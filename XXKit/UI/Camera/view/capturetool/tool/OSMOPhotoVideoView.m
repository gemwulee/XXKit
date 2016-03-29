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
#import "DJIIPhoneCameraViewController.h"

@interface OSMOPhotoVideoView()
@property(nonatomic,strong) UIImageView *imageViewBg;
@property(nonatomic,strong) UIImageView *imageViewSaving;
@property(nonatomic,strong) UIButton    *buttonCapture;

@end

@implementation OSMOPhotoVideoView

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
    
    _imageViewBg.image = [UIImage imageNamed:@"handle_camera_tool_bg"];
    _imageViewSaving.image = [UIImage imageNamed:@"handle_camera_tool_saving"];
    
    [self reloadSkins];
}

-(void) resetEvent
{
    [_buttonCapture removeTarget:nil
                       action:NULL
             forControlEvents:UIControlEventAllEvents];
    
    switch (self.cameraModel.captureMode) {
        case DJIIPhone_PhotoModel:
        {
            if(self.camera){
                [_buttonCapture addTarget:self.camera action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
                
            }else{
                assert(0);
            }
        }
            break;
        case DJIIPhone_VideoModel:
        {
            switch(self.cameraModel.videoState){
                case DJIIPhone_VideoRecordState_Stop:{
                    if(self.camera && [self.camera respondsToSelector:@selector(startRecordVideo)]){
                        [_buttonCapture addTarget:self.camera action:@selector(startRecordVideo) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
                    break;
                case DJIIPhone_VideoRecordState_ING:
                {
                    if(self.camera && [self.camera respondsToSelector:@selector(stopRecordVideo)]){
                        [_buttonCapture addTarget:self.camera action:@selector(stopRecordVideo) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
                    break;
            }
        }
            break;
            
        default:
            break;
    }
  
}

-(void) reloadSkins
{
    switch(self.cameraModel.captureMode){
        case DJIIPhone_PhotoModel:
        {
            [_buttonCapture setImage:[UIImage imageNamed:@"handle_camera_tool_photo"] forState:UIControlStateNormal];
        }
            break;
        case DJIIPhone_VideoModel:
        {
            if(self.cameraModel.videoState == DJIIPhone_VideoRecordState_Stop){
                [_buttonCapture setImage:[UIImage imageNamed:@"handle_camera_tool_video"] forState:UIControlStateNormal];
            }else{
                [_buttonCapture setImage:[UIImage imageNamed:@"handle_camera_tool_video_stop"] forState:UIControlStateNormal];
            }

        }
            break;
    }

    [self resetEvent];

}

@end
