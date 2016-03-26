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
#import <CoreGraphics/CoreGraphics.h>

@interface OSMOPhoneController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

//AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) AVCaptureSession            *session;
//预览图层，来显示照相机拍摄到的画面
@property (nonatomic, strong) CALayer  *previewLayer;
//预览界面
@property (nonatomic, strong) OSMOPhoneView *cameraShowView;
//滤镜
@property (nonatomic, strong) CIFilter *filter;
//CIContext
@property (nonatomic, strong) CIContext *context;

@property (nonatomic, strong) NSArray *filterNames;

@property (nonatomic, strong) CIImage *ciImage;
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
    self.session = [AVCaptureSession new];
    [self.session beginConfiguration];
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    
    //AVCaptureDeviceInput对象是输入流
    AVCaptureDeviceInput   *videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:nil];
    if ([self.session canAddInput:videoInput]) {
        [self.session addInput:videoInput];
    }
    
    AVCaptureVideoDataOutput *dataOutput = [[AVCaptureVideoDataOutput alloc] init];
    NSDictionary * outputSettings =   [NSDictionary dictionaryWithObject: [NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    dataOutput.videoSettings = outputSettings;
    
    dataOutput.alwaysDiscardsLateVideoFrames = true;
    
    if ([self.session canAddOutput:dataOutput]) {
        [self.session addOutput:dataOutput];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL);
    [dataOutput setSampleBufferDelegate:self queue:queue];
    
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
        self.previewLayer = [CALayer layer];
         self.previewLayer.bounds = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
         self.previewLayer.position = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
//        [self.previewLayer setAffineTransform:CGAffineTransformMakeRotation(M_PI/2.0)];
        self.previewLayer.anchorPoint = CGPointZero;
        self.previewLayer.bounds = self.view.bounds;
        
        
        [self.view.layer insertSublayer:_previewLayer atIndex:0];
    }
}

- (void) setCIFilter{
    EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSDictionary *options = @{kCIContextWorkingColorSpace :  [NSNull null]};
    self.context = [CIContext contextWithEAGLContext:eaglContext options:options];
}

#pragma mark- capture delegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    CIImage *outputImage = [[CIImage alloc]initWithCVPixelBuffer:imageBuffer];
    
    if(_filter != nil){
        [self.filter setValue:outputImage forKey:kCIInputImageKey];
        outputImage = _filter.outputImage;
    }else{
        self.filter = [CIFilter filterWithName:@"CIPhotoEffectInstant"];

    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    CGAffineTransform t;
    if(orientation == UIDeviceOrientationPortrait) {
        t = CGAffineTransformMakeRotation((CGFloat)(-M_PI / 2.0));
    } else if(orientation == UIDeviceOrientationPortraitUpsideDown) {
        t = CGAffineTransformMakeRotation((CGFloat)(M_PI / 2.0));
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        t = CGAffineTransformMakeRotation((CGFloat)(M_PI));
    } else {
        t = CGAffineTransformMakeRotation(0);
    }
    
    
    outputImage = [outputImage imageByApplyingTransform:t];
    
    CGImageRef cgImage = [_context createCGImage:outputImage fromRect:outputImage.extent];
    self.ciImage = outputImage;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.previewLayer.contents = (__bridge id _Nullable)(cgImage);
        CGImageRelease(cgImage);
    });
}

@end
