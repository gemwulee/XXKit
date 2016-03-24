//
//  OSMOPhoneController.m
//  XXKit
//
//  Created by tomxiang on 3/23/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//http://blog.csdn.net/wrathli/article/details/39431287
//http://blog.csdn.net/zhangao0086/article/details/39433519

#import "OSMOPhoneController.h"
#import <AVFoundation/AVFoundation.h>
#import "OSMOPhoneView.h"
#import "XXBase.h"
#import "Masonry.h"
#import <CoreImage/CoreImage.h>

@interface OSMOPhoneController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

//AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) AVCaptureSession            *session;
//AVCaptureDeviceInput对象是输入流
@property (nonatomic, strong) AVCaptureDeviceInput        *videoInput;
//照片输出流对象，当然我的照相机只有拍照功能，所以只需要这个对象就够了
@property (nonatomic, strong) AVCaptureVideoDataOutput   *dataOutput;
//预览图层，来显示照相机拍摄到的画面
@property (nonatomic, strong) AVCaptureVideoPreviewLayer  *previewLayer;
//预览界面
@property (nonatomic, strong) OSMOPhoneView *cameraShowView;
//滤镜
@property (nonatomic, strong) CIFilter *filter;
//CIContext
@property (nonatomic, strong) CIContext *context;

@property (nonatomic, strong) NSArray *filterNames;
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
    [self initData];
    [self initViews];
    [self initCamera];
    [self initEvent];
    
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
#pragma mark- 初始化数据
- (void) initData
{
    self.filterNames = @[@"CIColorInvert",@"CIPhotoEffectMono",@"CIPhotoEffectInstant",@"CIPhotoEffectTransfer"];
}

- (void) initViews
{
    self.cameraShowView = [[[NSBundle mainBundle]loadNibNamed:@"OSMOPhoneView_landscape" owner:self options:nil]objectAtIndex:0];
    self.cameraShowView.filterArray = self.filterNames;
    self.cameraShowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.cameraShowView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_cameraShowView];
}

-(void) initCamera
{
    [self setCIFilter];
    [self setUpCameraLayer];
}
-(void) initEvent
{
    if (self.cameraShowView) {
        @weakify(self);
        self.cameraShowView.selectBlock = ^(NSInteger row){
            @strongify(self)
//            [self showAllFilters];
            NSLog(@"row:%ld",row);
            NSString *filterName = [self.filterNames objectAtIndex:row];
            self.filter = [CIFilter filterWithName:filterName];
        };
    }
}

#pragma mark 查看所有内置滤镜
-(void)showAllFilters{
    NSArray *filterNames=[CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    for (NSString *filterName in filterNames) {
        CIFilter *filter=[CIFilter filterWithName:filterName];
        NSLog(@"\rfilter:%@\rattributes:%@",filterName,[filter attributes]);
    }
}

- (void) initialSession
{
    //这个方法的执行我放在init方法里了
    self.session = [[AVCaptureSession alloc] init];
    [self.session beginConfiguration];
    self.session.sessionPreset = AVCaptureSessionPresetLow;
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:nil];
    //[self fronCamera]方法会返回一个AVCaptureDevice对象，因为我初始化时是采用前摄像头，所以这么写，具体的实现方法后面会介绍
    self.dataOutput = [[AVCaptureVideoDataOutput alloc] init];

    //[[NSDictionary alloc] initWithObjectsAndKeys:kCVPixelFormatType_32BGRA,(NSString*)kCVPixelBufferPixelFormatTypeKey, nil];
    //这是输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    //[[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];

    NSDictionary * outputSettings =   [NSDictionary dictionaryWithObject: [NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    self.dataOutput.videoSettings = outputSettings;
    self.dataOutput.alwaysDiscardsLateVideoFrames = true;
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.dataOutput]) {
        [self.session addOutput:self.dataOutput];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL);
    [self.dataOutput setSampleBufferDelegate:self queue:queue];
    
    [self.session commitConfiguration];
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

- (void) setCIFilter{
    EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSDictionary *options = @{kCIContextWorkingColorSpace :  [NSNull null]};
    self.context = [[CIContext alloc] init];
    self.context = [CIContext contextWithEAGLContext:eaglContext options:options];
}

#pragma mark- capture delegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    CIImage *outputImage = [[CIImage alloc]initWithCVPixelBuffer:imageBuffer];
    
    if(_filter != nil){
        [_filter setValue:outputImage forKey:kCIInputImageKey];
        outputImage = _filter.outputImage;
    }
    CGImageRef cgImage = [_context createCGImage:outputImage fromRect:outputImage.extent];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.previewLayer.contents = (__bridge id _Nullable)(cgImage);
    });
}

@end
