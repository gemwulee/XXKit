//
//  OSMOPhoneController.m
//  XXKit
//
//  Created by tomxiang on 3/23/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//http://blog.csdn.net/wrathli/article/details/39431287

#import "OSMOPhoneController.h"
#import <AVFoundation/AVFoundation.h>
#import "OSMOPhoneView.h"
#import "XXBase.h"
#import "Masonry.h"

@interface OSMOPhoneController ()

//AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) AVCaptureSession            * session;

//AVCaptureDeviceInput对象是输入流
@property (nonatomic, strong) AVCaptureDeviceInput        * videoInput;

//照片输出流对象，当然我的照相机只有拍照功能，所以只需要这个对象就够了
@property (nonatomic, strong) AVCaptureStillImageOutput   * stillImageOutput;

//预览图层，来显示照相机拍摄到的画面
@property (nonatomic, strong) AVCaptureVideoPreviewLayer  * previewLayer;

//预览界面
@property (nonatomic, strong) OSMOPhoneView * cameraShowView;

@end

@implementation OSMOPhoneController

-(instancetype)init
{
    if (self = [super init]) {
        [self initialSession];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self setUpCameraLayer];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.session) {
        [self.session startRunning];
    }
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear: animated];
    if (self.session) {
        [self.session stopRunning];
    }
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.cameraShowView.frame = self.view.bounds;
    [self.previewLayer setFrame:self.cameraShowView.bounds];
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (deviceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        [_previewLayer.connection setVideoOrientation:AVCaptureVideoOrientationPortraitUpsideDown];
    
    else if (deviceOrientation == UIInterfaceOrientationPortrait)
        [_previewLayer.connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    else if (deviceOrientation == UIInterfaceOrientationLandscapeLeft)
        [_previewLayer.connection setVideoOrientation:AVCaptureVideoOrientationLandscapeLeft];
    
    else
        [_previewLayer.connection setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
    
}
- (BOOL)prefersStatusBarHidden//for iOS7.0
{
    return YES;
}

- (void) initViews
{
//    if([UIDevice isLandscape]){
        self.cameraShowView = [[[NSBundle mainBundle]loadNibNamed:@"OSMOPhoneView_landscape" owner:self options:nil]objectAtIndex:0];
        self.cameraShowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    }
    
    self.cameraShowView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_cameraShowView];
}

- (void) initialSession
{
    //这个方法的执行我放在init方法里了
    self.session = [[AVCaptureSession alloc] init];
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:nil];
    //[self fronCamera]方法会返回一个AVCaptureDevice对象，因为我初始化时是采用前摄像头，所以这么写，具体的实现方法后面会介绍
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    //这是输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            //设置device属性
            
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (void) setUpCameraLayer
{
    if (self.previewLayer == nil) {
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        UIView * view = self.cameraShowView;
        CALayer * viewLayer = [view layer];
        [viewLayer setMasksToBounds:YES];
        
        CGRect bounds = [view bounds];
        
        [self.previewLayer setFrame:bounds];
        [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        
        [viewLayer insertSublayer:self.previewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
        
    }
}

@end
