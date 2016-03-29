//
//  DJIIPhoneCameraViewController.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "DJIIPhoneCameraViewController.h"
#import "DJIIPhoneCameraView.h"
#import "DJIIPhoneCameraModel.h"


@interface DJIIPhoneCameraViewController()
@property(nonatomic,strong) DJIIPhoneCameraView *cameraView;
@end
@implementation DJIIPhoneCameraViewController

-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model
{
    if (self = [super init]) {
         self.cameraView = [[DJIIPhoneCameraView alloc] initWithFrame:CGRectZero withModel:model];
    }
    return self;
}

-(void) layoutInView:(UIView*) view{
    _cameraView.frame = view.frame;
    [view addSubview:_cameraView];
}

-(void) openCamera{
    [self.cameraView openCamera];
}

-(void) closeCamera{
     [self.cameraView closeCamera];
}

-(void) resetCameraFrame:(CGRect) bounds{
    [self.cameraView resetCameraFrame:bounds];
}

-(void) takePhoto:(id) sender{
    [self.cameraView takePhoto];
}

-(void) swapFrontAndBackCameras
{
    [self.cameraView swapFrontAndBackCameras];
}

-(void) buttonPlayBack:(id) sender{
    NSLog(@"回放..");
}

//开始录制视频
-(void) startRecordVideo
{
    [self.cameraView startRecordVideo];
}

//停止录制视频
-(void) stopRecordVideo
{
    [self.cameraView stopRecordVideo];
}

-(void) reloadSkins
{
    [self.cameraView reloadSkins];
}
@end
