//
//  DJIIPhoneCameraView.m
//  Phantom3
//
//  Created by tomxiang on 3/24/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import "DJIIPhoneCameraViewController.h"
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>
#import "DJIIPhoneCameraModel.h"

@interface DJIIPhoneCameraViewController()<AVCaptureVideoDataOutputSampleBufferDelegate,UIGestureRecognizerDelegate>
{
    CGFloat beginGestureScale;
    CGFloat effectiveScale;
}

@property (nonatomic, strong) DJIIPhoneCameraModel   *cameraModel;
@property (nonatomic, strong) AVCaptureSession       *session;           //AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) CALayer                *previewLayer;      //预览图层，来显示照相机拍摄到的画面

@property (nonatomic, strong) CIFilter               *filter;            //滤镜
@property (nonatomic, strong) CIContext              *context;
@property (nonatomic, strong) NSArray                *filterNames;
@property (nonatomic, strong) CIImage                *ciImage;


@property (nonatomic, strong) AVCaptureVideoDataOutput *dataOutput;
@end

@implementation DJIIPhoneCameraViewController

-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model{
    if (self = [super init]) {
        self.cameraModel = model;
        [self initAVCapture];
        [self setUpGesture];
    }
    return self;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark- 初始化数据
-(void)initAVCapture{
    self.session = [AVCaptureSession new];
    [self.session beginConfiguration];
    self.session.sessionPreset = AVCaptureSessionPreset1280x720;//AVCaptureSessionPreset3840x2160;
    
    //AVCaptureDeviceInput对象是输入流
    AVCaptureDevice *device = (self.cameraModel.devicePosition == DJIIPhone_DevicePositionFront)?[self frontCamera]:[self backCamera];
    AVCaptureDeviceInput   *videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    if ([self.session canAddInput:videoInput]) {
        [self.session addInput:videoInput];
    }
    
    _dataOutput = [[AVCaptureVideoDataOutput alloc] init];
    NSDictionary * outputSettings =   [NSDictionary dictionaryWithObject: [NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    _dataOutput.videoSettings = outputSettings;
    _dataOutput.alwaysDiscardsLateVideoFrames = true;
    
    if ([self.session canAddOutput:_dataOutput]) {
        [self.session addOutput:_dataOutput];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL);
    [_dataOutput setSampleBufferDelegate:self queue:queue];
    
    [self.session commitConfiguration];
    
    self.previewLayer = [CALayer layer];
    self.previewLayer.anchorPoint = CGPointZero;
    self.previewLayer.bounds = self.view.bounds;
    
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSDictionary *options = @{kCIContextWorkingColorSpace :  [NSNull null]};
    _context = [CIContext contextWithEAGLContext:eaglContext options:options];

}

#pragma mark- 摄像头
- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self openCamera];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    [self closeCamera];
}

-(void) openCamera{
    if (_session) {
        [_session startRunning];
    }
}

-(void) closeCamera{
    
    if (_session) {
        [_session stopRunning];
    }
}

#pragma mark- capture delegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage *outputImage = [[CIImage alloc]initWithCVPixelBuffer:imageBuffer];
    
    if(_filter != nil){
        [self.filter setValue:outputImage forKey:kCIInputImageKey];
        outputImage = _filter.outputImage;
    }
    
    outputImage = [outputImage imageByApplyingTransform:[self getCameraTransform]];
    
    CGImageRef cgImage = [_context createCGImage:outputImage fromRect:outputImage.extent];
    self.ciImage = outputImage;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.previewLayer.contents = (__bridge_transfer id _Nullable)((cgImage));
    });
}


-(void) takePhoto{
    if (self.ciImage == nil){
        return;
    }
    
    CGImageRef cgImage = [_context createCGImage:_ciImage fromRect:_ciImage.extent];
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithCGImage: cgImage], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark- 旋转，重置frame

-(void)viewDidLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.previewLayer setFrame:self.view.bounds];
}



#pragma mark- 根据model刷新参数
-(void) reloadSkins
{
    
}

-(void) swapFrontAndBackCameras
{
    NSArray *inputs = _session.inputs;
    for ( AVCaptureDeviceInput *input in inputs ) {
        AVCaptureDevice *device = input.device;
        if ( [device hasMediaType:AVMediaTypeVideo] ) {
            AVCaptureDevicePosition position = device.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionFront)
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            else
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            // beginConfiguration ensures that pending changes are not applied immediately
            [_session beginConfiguration];
            
            [_session removeInput:input];
            [_session addInput:newInput];
            
            // Changes take effect once the outermost commitConfiguration is invoked.
            [_session commitConfiguration];
            break;
        }
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


//获取旋转角度
-(CGAffineTransform) getCameraTransform
{
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
    return t;
}

//开始录制视频
-(void) startRecordVideo
{
    NSLog(@"正在录制视频");
}

//停止录制视频
-(void) stopRecordVideo
{
    NSLog(@"结束录制");
}

#pragma mark- 创建手势
- (void)setUpGesture{
    
    beginGestureScale = effectiveScale = 1.f;
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinch.delegate = self;
    [self.view addGestureRecognizer:pinch];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
        beginGestureScale = effectiveScale;
    }
    return YES;
}

// scale image depending on users pinch gesture
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    BOOL allTouchesAreOnThePreviewLayer = YES;
    NSUInteger numTouches = [recognizer numberOfTouches], i;
    for ( i = 0; i < numTouches; ++i ) {
        CGPoint location = [recognizer locationOfTouch:i inView:self.view];
        CGPoint convertedLocation = [_previewLayer convertPoint:location fromLayer:_previewLayer.superlayer];
        if ( ! [_previewLayer containsPoint:convertedLocation] ) {
            allTouchesAreOnThePreviewLayer = NO;
            break;
        }
    }
    
    if ( allTouchesAreOnThePreviewLayer ) {
        effectiveScale = beginGestureScale * recognizer.scale;
        CGFloat maxScaleAndCropFactor = [[_dataOutput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];
        
        if (effectiveScale < 1.f) {
            return;
        }
//        if (effectiveScale > maxScaleAndCropFactor)
//            effectiveScale = 1.f / effectiveScale;
        
        NSLog(@"effectiveScale 1:%f ", effectiveScale);
        
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:.025];
//        [[UIScreen mainScreen] setBrightness:effectiveScale];

        
        [self.view.layer setAffineTransform:CGAffineTransformMakeScale(effectiveScale, effectiveScale)];
        [CATransaction commit];
    }
}
@end
