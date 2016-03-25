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

@interface OSMOIPhoneViewController ()
@property(nonatomic,strong) DJIIPhoneCameraView  *camera;
@property(nonatomic,strong) OSMOIPhoneHandler    *handler;
@property(nonatomic,strong) DJIIPhoneCameraModel *model;
@end


@implementation OSMOIPhoneViewController

-(instancetype)init
{
    if (self = [super init]) {
        self.model = [DJIIPhoneCameraModel new];
        self.camera = [[DJIIPhoneCameraView alloc] initWithFrame:self.view.frame cameraModel:_model];
        [self.view addSubview:_camera];
        self.handler = [OSMOIPhoneHandler new];
    }
    return self;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.camera resetCameraFrame:self.view.bounds];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.camera openCamera];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear: animated];
    [self.camera closeCamera];
}

@end
