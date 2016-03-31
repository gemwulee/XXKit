//
//  OSMOIPhoneViewController.m
//  Phantom3
//
//  Created by tomxiang on 3/25/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import "OSMOIPhoneViewController.h"
#import "OSMOIPhoneHandler.h"
#import "DJIIPhoneCameraModel.h"
#import "OSMOCaptureToolView.h"
#import "XXBase.h"
#import "DJIIPhoneCameraViewController.h"
#import "OSMORightSettingView.h"
#import "OSMOEventAction.h"

@interface OSMOIPhoneViewController ()

@property(nonatomic,strong)  OSMOCaptureToolView  *captureToolPlaceView;
@property(nonatomic,strong)  OSMORightSettingView *rightSettingPlaceView;

@property(nonatomic,strong)  DJIIPhoneCameraViewController  *cameraVC;

@property(nonatomic,strong)  DJIIPhoneCameraView  *camera;

@property(nonatomic,strong)  OSMOEventAction      *cameraAction;

@property(nonatomic,strong)  OSMOIPhoneHandler    *handler;
@property(nonatomic,strong)  DJIIPhoneCameraModel *model;

@end


@implementation OSMOIPhoneViewController

-(instancetype)init{
    if (self = [super init]) {
        _model        = [DJIIPhoneCameraModel new];
        _cameraVC     = [[DJIIPhoneCameraViewController alloc] initWithModel:_model];

//        _camera       = [[DJIIPhoneCameraView alloc] initWithFrame:CGRectZero withModel:_model];

        _cameraAction = [[OSMOEventAction alloc] initWithModel:_model camera:_cameraVC];
        _handler      = [OSMOIPhoneHandler new];
        [self addKVOModel];

    }
    return self;
}

-(void)dealloc
{
    [self removeKVOModel];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];

}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [_camera openCamera];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
//    [_camera closeCamera];
}

-(void) initViews
{    
    _captureToolPlaceView = [[OSMOCaptureToolView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    _rightSettingPlaceView = [[OSMORightSettingView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
//    _camera.frame = self.view.frame;
    
//    [self.view addSubview:_camera];
    
    [self addChildViewController:_cameraVC];
    [self.view addSubview:_cameraVC.view];
    
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
//    [_camera resetCameraFrame:self.view.bounds];
    
    if ([UIDevice isLandscape]) {
        [_captureToolPlaceView setFrame:CGRectMake(0, (self.view.height - OSMO_ICON_HEIGHT * 5)*1.f/2, OSMO_ICON_WIDTH , OSMO_ICON_HEIGHT * 5)];
        [_rightSettingPlaceView  setFrame:CGRectMake(self.view.width-OSMO_ICON_WIDTH, 0, OSMO_ICON_WIDTH,self.view.height)];

    }else{
        [_captureToolPlaceView setFrame:CGRectMake((self.view.width - OSMO_ICON_WIDTH * 5)*1.f/2, self.view.height - OSMO_ICON_HEIGHT, self.view.width, OSMO_ICON_WIDTH)];
        [_rightSettingPlaceView setFrame:CGRectMake(0, 0,self.view.width, OSMO_ICON_HEIGHT)];
    }

    [_captureToolPlaceView reloadSkins];
    [_rightSettingPlaceView reloadSkins];
}

#pragma mark- 增加观察者
-(void) addKVOModel
{
    [self addObserver:self forKeyPath:@"model.captureMode" options:0 context:nil];
    [self addObserver:self forKeyPath:@"model.devicePosition" options:0 context:nil];
    [self addObserver:self forKeyPath:@"model.videoState" options:0 context:nil];
}

-(void) removeKVOModel
{
    [self removeObserver:self forKeyPath:@"model.captureMode"];
    [self removeObserver:self forKeyPath:@"model.devicePosition"];
    [self removeObserver:self forKeyPath:@"model.videoState"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"model.captureMode"] || [keyPath isEqualToString:@"model.videoState"]) {
        if(_captureToolPlaceView){
            [_captureToolPlaceView reloadSkins];
            [_cameraVC reloadSkins];
        }
    }
    
    if([keyPath isEqualToString:@"model.devicePosition"]){
        [_cameraVC swapFrontAndBackCameras];
    }

}

@end
