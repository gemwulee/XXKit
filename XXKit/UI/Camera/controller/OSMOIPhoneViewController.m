//
//  OSMOIPhoneViewController.m
//  Phantom3
//
//  Created by tomxiang on 3/25/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import "OSMOIPhoneViewController.h"
#import "DJIIPhoneCameraView.h"
#import "OSMOIPhoneHandler.h"
#import "DJIIPhoneCameraModel.h"
#import "OSMOCaptureToolView.h"
#import "OSMOCaptureToolController.h"

@interface OSMOIPhoneViewController ()

@property(nonatomic,strong)  UIView *captureToolPlaceView;
@property(nonatomic,strong)  UIView *rightSettingPlaceView;

@property(nonatomic,strong)  DJIIPhoneCameraView  *camera;
@property(nonatomic,strong)  OSMOIPhoneHandler    *handler;
@property(nonatomic,strong)  DJIIPhoneCameraModel *model;

@end


@implementation OSMOIPhoneViewController

-(instancetype)init{
    if (self = [super init]) {
        _model = [DJIIPhoneCameraModel new];
        _camera = [[DJIIPhoneCameraView alloc] initWithFrame:self.view.frame cameraModel:_model];
        [self.view addSubview:_camera];
        _handler = [OSMOIPhoneHandler new];
    }
    return self;
}

- (void) viewDidLoad{
    [super viewDidLoad];
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_camera openCamera];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    [_camera closeCamera];
}

#pragma mark- 横竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [[UIApplication sharedApplication] statusBarOrientation];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [_camera resetCameraFrame:self.view.bounds];
}

-(void) 


@end
