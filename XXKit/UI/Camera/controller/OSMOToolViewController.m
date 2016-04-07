//
//  OSMOToolViewController.m
//  XXKit
//
//  Created by tomxiang on 4/3/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOToolViewController.h"
#import "OSMOIPhoneViewController.h"
#import "OSMOIPhoneHandler.h"
#import "DJIIPhoneCameraModel.h"
#import "OSMOCaptureToolView.h"
#import "DJIIPhoneCameraViewController.h"
#import "OSMORightSettingView.h"
#import "OSMOEventAction.h"
#import "Macro.h"
#import "XXBase.h"
#import "OSMOMenuPlaceView.h"
#import "OSMOManualmodeView.h"

@interface OSMOToolViewController ()

@property(nonatomic,weak)  OSMOEventAction      *cameraAction;
@property(nonatomic,weak)  DJIIPhoneCameraModel *model;

@end


@implementation OSMOToolViewController

-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model action:(OSMOEventAction*) action{
    if (self = [super init]) {
        [self initNotification];
        self.model = model;
        self.cameraAction = action;
        
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    
}

-(void) initNotification
{
//    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
}

-(void) initViews
{
    self.view.backgroundColor = [UIColor clearColor];
    _captureToolPlaceView = [[OSMOCaptureToolView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    _rightSettingPlaceView = [[OSMORightSettingView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    _osmoMenumodeView = [[OSMOManualmodeView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    
    _leftFirstMenuPlaceView  = [[OSMOMenuPlaceView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    _leftSecondMenuPlaceView = [[OSMOMenuPlaceView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    _rightFirstMenuPlaceView = [[OSMOMenuPlaceView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    
    [self.view addSubview:_captureToolPlaceView];
    [self.view addSubview:_rightSettingPlaceView];
    
    [self.view addSubview:_leftFirstMenuPlaceView];
    [self.view addSubview:_leftSecondMenuPlaceView];
    [self.view addSubview:_rightFirstMenuPlaceView];
    
    [self.view addSubview:_osmoMenumodeView];
}

#pragma mark- 横竖屏
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}
- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self refreshViewFrame];
}

#define GUDINGWIDTH 200.f

-(void) refreshViewFrame
{
    if ([UIDevice isLandscape]) {
        [_captureToolPlaceView setFrame:CGRectMake(0, 0, paramSettingWidth, MAIN_SCREEN_HEIGHT)];
        [_rightSettingPlaceView setFrame:CGRectMake(MAIN_SCREEN_WIDTH-rightBarWidth, 0, rightBarWidth,MAIN_SCREEN_HEIGHT )];
     
        [_leftFirstMenuPlaceView setFrame:CGRectMake(self.captureToolPlaceView.width+6, 0, self.captureToolPlaceView.width, MAIN_SCREEN_HEIGHT)];
        [_leftSecondMenuPlaceView setFrame:CGRectMake(self.leftFirstMenuPlaceView.x + self.leftFirstMenuPlaceView.width,0,self.captureToolPlaceView.width, MAIN_SCREEN_HEIGHT)];
        [_rightFirstMenuPlaceView setFrame:CGRectMake(_rightSettingPlaceView.x - 200,(MAIN_SCREEN_HEIGHT-timelapseHeight)/2,200,timelapseHeight)];
        
        [_osmoMenumodeView setFrame: CGRectMake((MAIN_SCREEN_WIDTH-timelapseHeight)/2, 20, timelapseHeight,osmoMenumodeViewHeight)];
    }else{
        
        [_captureToolPlaceView setFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT - paramSettingWidth, MAIN_SCREEN_WIDTH, paramSettingWidth)];
        [_rightSettingPlaceView setFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, rightBarWidth)];
        
        [_leftFirstMenuPlaceView setFrame:CGRectMake(0, self.captureToolPlaceView.y-6-self.captureToolPlaceView.height, self.captureToolPlaceView.width, self.captureToolPlaceView.height)];
        [_leftSecondMenuPlaceView setFrame:CGRectMake(0, self.leftFirstMenuPlaceView.y-self.leftFirstMenuPlaceView.height, self.leftFirstMenuPlaceView.width, self.leftFirstMenuPlaceView.height)];
        [_rightFirstMenuPlaceView setFrame: CGRectMake((MAIN_SCREEN_WIDTH-timelapseHeight)/2, self.rightSettingPlaceView.height, timelapseHeight, 200) ];
        
        [_osmoMenumodeView setFrame: CGRectMake((MAIN_SCREEN_WIDTH-timelapseHeight)/2, self.rightSettingPlaceView.height, timelapseHeight,osmoMenumodeViewHeight)];

        
    }
    
    [_captureToolPlaceView reloadSkins];
    [_rightSettingPlaceView reloadSkins];

    [_rightFirstMenuPlaceView reloadSkins];
    [_leftFirstMenuPlaceView reloadSkins];
    [_leftSecondMenuPlaceView reloadSkins];
    
}

//- (void)orientationChanged:(NSNotification *)notification{
//    
//    [_rightFirstMenuPlaceView reloadSkins];
//    [_leftFirstMenuPlaceView reloadSkins];
//    [_leftSecondMenuPlaceView reloadSkins];
//    
//    [_captureToolPlaceView reloadSkins];
//    [_rightSettingPlaceView reloadSkins];
//}





@end
