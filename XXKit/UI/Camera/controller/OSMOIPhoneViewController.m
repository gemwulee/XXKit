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
//#import "Macro.h"
//#import "DJIHandleMainController.h"
#import "OSMOIPhoneViewController+LandScape.h"
#import "OSMOIPhoneViewController+Portrait.h"
//#import "DJIHandleSettingViewController.h"
//#import "DJIHandleRightBarController.h"
#import "OSMOCaptureToolView.h"
#import "OSMOCaptureToolController.h"

@interface OSMOIPhoneViewController ()
@property(nonatomic,strong) DJIIPhoneCameraView  *camera;
@property(nonatomic,strong) OSMOIPhoneHandler    *handler;
@property(nonatomic,strong) DJIIPhoneCameraModel *model;


//UI
//@property(nonatomic,assign)  DJILayoutType type;

@end


@implementation OSMOIPhoneViewController

-(instancetype)init{
    if (self = [super init]) {
        self.model = [DJIIPhoneCameraModel new];
        
        self.camera = [[DJIIPhoneCameraView alloc] initWithFrame:self.view.frame cameraModel:_model];
        [self.view addSubview:_camera];
        _camera.layer.zPosition = -1000;
        
        self.handler = [OSMOIPhoneHandler new];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.camera openCamera];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    [self.camera closeCamera];
}

//- (void) initData{
//    _type = DJILayoutUnknown;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    self.captureToolController = [[OSMOCaptureToolController alloc] init];
//    self.rightBarController = [[DJIHandleRightBarController alloc] init];
//
//}
//
//#pragma mark- Event
//-(void)clickHandleSettingButtonRightBarController:(id)sender{
//    if ( _settingVC == nil ){
//        _settingVC = [[DJIHandleSettingViewController alloc] initWithDefaultNib];
//        
//        _settingVC.view.backgroundColor=[UIColor clearColor];
//        
//        
//        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        self.modalPresentationStyle = UIModalPresentationCurrentContext;
//        _settingVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        weakSelf(target);
//        _settingVC.exitFromSetting = ^(){
//            weakReturn(target);
//            //点了退出
//            
//        };
//        
//        [self presentViewController:_settingVC animated:YES completion:nil];
//        
//    }
//    else{
//        [_settingVC.stageVC popToRootViewWithAnimated:NO] ;
//        [self presentViewController:_settingVC animated:YES completion:nil];
//    }
//}

#pragma mark- 横竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [[UIApplication sharedApplication] statusBarOrientation];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.camera resetCameraFrame:self.view.bounds];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    [self caculateOrientation];
}

//-(void)caculateOrientation{
//    DJILayoutType type = DJILayoutUnknown;
//    if(MAIN_SCREEN_HEIGHT < MAIN_SCREEN_WIDTH){
//        type = DJILandscape;
//    }
//    else{
//        type = DJIPotrait;
//    }
//    if(_type != type){
//        _type = type;
//        [self relayout];
//    }
//}
//- (void)relayout{
//    if(_type == DJILandscape)
//        [self layoutInLandscape];
//    else
//        [self layoutInPotrait];
//    
//    [self layoutHandleSubViews:_type];
//}




@end
