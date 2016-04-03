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
#import "OSMOLeftFirstMenuPlaceView.h"
#import "OSMOLeftSecondMenuPlaceView.h"
#import "OSMORightFirstMenuPlaceView.h"
#import "Macro.h"
#import "XXBase.h"
#import "OSMOToolViewController.h"
#import "OSMOToolWindow.h"

@interface OSMOIPhoneViewController ()

@property(nonatomic,strong)  OSMOEventAction        *cameraAction;

@property(nonatomic,strong)  OSMOIPhoneHandler      *handler;
@property(nonatomic,strong)  DJIIPhoneCameraModel   *model;

@property(nonatomic,strong)  OSMOToolWindow         *toolWindow;
@end


@implementation OSMOIPhoneViewController

-(instancetype)init{
    if (self = [super init]) {
        _model        = [DJIIPhoneCameraModel new];
        _cameraVC     = [[DJIIPhoneCameraViewController alloc] initWithModel:_model];
        _cameraAction = [[OSMOEventAction alloc] initWithModel:_model camera:_cameraVC rootVC:self];
        
        _toolVC = [[OSMOToolViewController alloc] initWithModel:_model action:_cameraAction];
    }
    [self addKVOModel];
    return self;
}

-(void)dealloc
{
    [self removeKVOModel];
    [_toolWindow hideOSMOToolVC];
    [_toolWindow removeFromSuperview];
    _toolWindow = nil;
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
    
    [[XXFPSEngine sharedInstance] startMonistor];

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
        if(_toolVC.captureToolPlaceView){
            [_toolVC.captureToolPlaceView reloadSkins];
            [_cameraVC reloadSkins];
        }
    }
    
    if([keyPath isEqualToString:@"model.devicePosition"]){
        [_cameraVC swapFrontAndBackCameras];
    }
    
}

@end
