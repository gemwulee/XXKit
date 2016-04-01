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

@interface OSMOIPhoneViewController ()

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
            
        _cameraAction = [[OSMOEventAction alloc] initWithModel:_model camera:_cameraVC rootVC:self];
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
    
    _leftFirstMenuPlaceView  = [[OSMOLeftFirstMenuPlaceView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    _leftSecondMenuPlaceView = [[OSMOLeftSecondMenuPlaceView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    _rightFirstMenuPlaceView = [[OSMORightFirstMenuPlaceView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    
    _leftFirstMenuPlaceView.backgroundColor = [UIColor redColor];
    _leftSecondMenuPlaceView.backgroundColor = [UIColor blueColor];
    _rightFirstMenuPlaceView.backgroundColor = [UIColor grayColor];
    
    [self addChildViewController:_cameraVC];
    [self.view addSubview:_cameraVC.view];
    
    [self.view addSubview:_captureToolPlaceView];
    [self.view addSubview:_rightSettingPlaceView];
    
    [self.view addSubview:_leftFirstMenuPlaceView];
    [self.view addSubview:_leftSecondMenuPlaceView];
    [self.view addSubview:_rightFirstMenuPlaceView];
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

#define GUDINGWIDTH 200.f

-(void) refreshViewFrame
{
    if ([UIDevice isLandscape]) {
        [self.captureToolPlaceView setFrame:CGRectMake(0, 0, paramSettingWidth, MAIN_SCREEN_HEIGHT)];
        [self.rightSettingPlaceView setFrame:CGRectMake(MAIN_SCREEN_WIDTH-rightBarWidth, 0, rightBarWidth,MAIN_SCREEN_HEIGHT )];
        
        [self.leftFirstMenuPlaceView setFrame:CGRectMake(self.captureToolPlaceView.width+6, 0, self.captureToolPlaceView.width, MAIN_SCREEN_HEIGHT)];
        [self.leftSecondMenuPlaceView setFrame:CGRectMake(self.leftFirstMenuPlaceView.x + self.leftFirstMenuPlaceView.width,0,self.captureToolPlaceView.width, MAIN_SCREEN_HEIGHT)];
        [self.rightFirstMenuPlaceView setFrame:CGRectMake(_rightSettingPlaceView.x - 200,(MAIN_SCREEN_HEIGHT-timelapseHeight)/2,200,timelapseHeight)];
    }else{
        
        [_captureToolPlaceView setFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT - paramSettingWidth, MAIN_SCREEN_WIDTH, paramSettingWidth)];
        [_rightSettingPlaceView setFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, rightBarWidth)];
        
        [self.leftFirstMenuPlaceView setFrame:CGRectMake(0, self.captureToolPlaceView.y-6-self.captureToolPlaceView.height, self.captureToolPlaceView.width, self.captureToolPlaceView.height)];
        [self.leftSecondMenuPlaceView setFrame:CGRectMake(0, self.leftFirstMenuPlaceView.y-self.leftFirstMenuPlaceView.height, self.leftFirstMenuPlaceView.width, self.leftFirstMenuPlaceView.height)];
        [self.rightFirstMenuPlaceView setFrame: CGRectMake((MAIN_SCREEN_WIDTH-timelapseHeight)/2, self.rightSettingPlaceView.height, timelapseHeight, 200) ];
        
    }

    [_rightFirstMenuPlaceView reloadSkins];
    [_leftFirstMenuPlaceView reloadSkins];
    [_leftSecondMenuPlaceView reloadSkins];
     
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
