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
#import "DJIIPhoneCameraViewController.h"
#import "OSMORightSettingView.h"
#import "OSMOEventAction.h"
#import "OSMOMenuPlaceView.h"
#import "Macro.h"
#import "XXBase.h"
#import "OSMOToolViewController.h"
#import "OSMOToolWindow.h"
#import "OSMOStatusObserveManager.h"

@interface OSMOIPhoneViewController ()

@property(nonatomic,strong)  OSMOEventAction          *cameraAction;

@property(nonatomic,strong)  OSMOIPhoneHandler        *handler;
@property(nonatomic,strong)  DJIIPhoneCameraModel     *model;
@property(nonatomic,strong)  OSMOToolWindow           *toolWindow;

@end


@implementation OSMOIPhoneViewController

-(instancetype)init{
    if (self = [super init]) {
        _model        = [DJIIPhoneCameraModel new];
        _cameraVC     = [[DJIIPhoneCameraViewController alloc] initWithModel:_model];
        _cameraAction = [[OSMOEventAction alloc] initWithModel:_model camera:_cameraVC rootVC:self];
        _toolVC = [[OSMOToolViewController alloc] initWithModel:_model action:_cameraAction];
        _observeManager = [[OSMOStatusObserveManager alloc] initWithModel:_model camera:_cameraVC rootVC:self camera:_cameraAction];
    }
    return self;
}

-(void)dealloc
{
    [_toolWindow hideOSMOToolVC];
    [_toolWindow removeFromSuperview];
    _toolWindow = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
}

-(void) initViews
{
    [self addChildViewController:_cameraVC];
    [self.view addSubview:_cameraVC.view];
    
    if(!_toolWindow){
        _toolWindow   = [[OSMOToolWindow alloc] initWithFrame:[UIScreen mainScreen].bounds toolViewController:_toolVC];
    }
    [_toolWindow showOSMOToolVC];
}

#pragma mark- 横竖屏
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)shouldAutorotate
{
    return NO;
}

@end
