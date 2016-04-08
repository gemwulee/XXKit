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
    _topManualPlaceView = [[OSMOMenuPlaceView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    
    _leftFirstMenuPlaceView  = [[OSMOMenuPlaceView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    _leftSecondMenuPlaceView = [[OSMOMenuPlaceView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    _rightFirstMenuPlaceView = [[OSMOMenuPlaceView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
    _topFirstPickerPlaceView = [[OSMOMenuPlaceView alloc] initWithFrame:CGRectZero withModel:_model camera:_cameraAction];
   
    _topManualPlaceView.backgroundColor = [UIColor grayColor];
    _topFirstPickerPlaceView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_captureToolPlaceView];
    [self.view addSubview:_rightSettingPlaceView];
    
    [self.view addSubview:_leftFirstMenuPlaceView];
    [self.view addSubview:_leftSecondMenuPlaceView];
    [self.view addSubview:_rightFirstMenuPlaceView];
    [self.view addSubview:_topManualPlaceView];
    [self.view addSubview:_topFirstPickerPlaceView];
    
    _topManualPlaceView.hidden = YES;
    _topFirstPickerPlaceView.hidden = YES;
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
        
        [_topManualPlaceView setFrame: CGRectMake((MAIN_SCREEN_WIDTH-timelapseHeight)/2, 20, timelapseHeight,20)];
        [_topFirstPickerPlaceView setFrame:CGRectMake((MAIN_SCREEN_WIDTH-timelapseHeight)/2, _topManualPlaceView.bottom, timelapseHeight,200)];
    }else{
        
        [_captureToolPlaceView setFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT - paramSettingWidth, MAIN_SCREEN_WIDTH, paramSettingWidth)];
        [_rightSettingPlaceView setFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, rightBarWidth)];
        
        [_leftFirstMenuPlaceView setFrame:CGRectMake(0, self.captureToolPlaceView.y-6-self.captureToolPlaceView.height, self.captureToolPlaceView.width, self.captureToolPlaceView.height)];
        [_leftSecondMenuPlaceView setFrame:CGRectMake(0, self.leftFirstMenuPlaceView.y-self.leftFirstMenuPlaceView.height, self.leftFirstMenuPlaceView.width, self.leftFirstMenuPlaceView.height)];
        [_rightFirstMenuPlaceView setFrame: CGRectMake((MAIN_SCREEN_WIDTH-timelapseHeight)/2, self.rightSettingPlaceView.bottom, timelapseHeight, 200) ];
        
        [_topManualPlaceView setFrame: CGRectMake(_rightFirstMenuPlaceView.x, _rightFirstMenuPlaceView.y, timelapseHeight,20)];
        [_topFirstPickerPlaceView setFrame:CGRectMake(_topManualPlaceView.x, _topManualPlaceView.bottom, timelapseHeight, 200)];
    }
    
    [_captureToolPlaceView reloadSkins];
    [_rightSettingPlaceView reloadSkins];
    
    [_leftFirstMenuPlaceView reloadSkinsSize];
    [_leftSecondMenuPlaceView reloadSkinsSize];

    [_rightFirstMenuPlaceView reloadSkinsSize];
    [_topManualPlaceView reloadSkinsSize];
    [_topFirstPickerPlaceView reloadSkinsSize];
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
