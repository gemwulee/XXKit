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
#import "XXBase.h"

#define paramSettingWidth  80
#define rightBarWidth 44

@interface OSMOIPhoneViewController ()

@property(nonatomic,strong)  OSMOCaptureToolView *captureToolPlaceView;
@property(nonatomic,strong)  UIView *rightSettingPlaceView;

@property(nonatomic,strong)  DJIIPhoneCameraView  *camera;
@property(nonatomic,strong)  OSMOIPhoneHandler    *handler;
@property(nonatomic,strong)  DJIIPhoneCameraModel *model;

@end


@implementation OSMOIPhoneViewController

-(instancetype)init{
    if (self = [super init]) {
        _model = [DJIIPhoneCameraModel new];
        _camera = [[DJIIPhoneCameraView alloc] initWithFrame:self.view.frame withModel:_model];
        [self.view addSubview:_camera];
        _handler = [OSMOIPhoneHandler new];
    }
    return self;
}

-(void)loadView{
    [super loadView];
    [self initViews];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_camera openCamera];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    [_camera closeCamera];
}

-(void) initViews
{
    _captureToolPlaceView = [[OSMOCaptureToolView alloc] initWithFrame:CGRectZero withModel:_model];
    _captureToolPlaceView.backgroundColor = [UIColor clearColor];
    
    _rightSettingPlaceView = [[UIView alloc] initWithFrame:CGRectZero];
    _rightSettingPlaceView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:_captureToolPlaceView];
    [self.view addSubview:_rightSettingPlaceView];
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

-(void)viewDidLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self refreshViewFrame];
}

-(void) refreshViewFrame
{
    [_camera resetCameraFrame:self.view.bounds];
    //_captureToolPlaceView::左下
    //_rightSettingPlaceView::右上
    if ([UIDevice isLandscape]) {
        [_captureToolPlaceView setFrame:CGRectMake((self.view.width - OSMO_ICON_WIDTH * 5)*1.f/2, self.view.height - paramSettingWidth, self.view.width, paramSettingWidth)];
        [_rightSettingPlaceView setFrame:CGRectMake(0, 0,self.view.width, rightBarWidth)];
    }else{
        [_captureToolPlaceView setFrame:CGRectMake(0, (self.view.height - OSMO_ICON_HEIGHT * 5)*1.f/2, paramSettingWidth, self.view.height)];
        [_rightSettingPlaceView  setFrame:CGRectMake(self.view.width-rightBarWidth, 0, rightBarWidth,self.view.height)];
    }

    
    [_captureToolPlaceView reloadSkins];
}
@end
