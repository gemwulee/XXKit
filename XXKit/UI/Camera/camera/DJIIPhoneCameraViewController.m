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
#import <ImageIO/ImageIO.h>

#define IMAGEOUTPUT 0
@interface DJIIPhoneCameraViewController()<AVCaptureVideoDataOutputSampleBufferDelegate,UIGestureRecognizerDelegate>
{
    CGFloat beginGestureScale;
    CGFloat effectiveScale;
}

@property (nonatomic, strong) DJIIPhoneCameraModel   *cameraModel;
@property (nonatomic, strong) AVCaptureSession       *session;           //AVCaptureSession对象来执行输入设备和输出设备之间的数据传递

@property (nonatomic, strong) CIFilter               *filter;            //滤镜
@property (nonatomic, strong) CIContext              *context;
@property (nonatomic, strong) NSArray                *filterNames;
@property (nonatomic, strong) CIImage                *ciImage;


//图片预览图层
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

//视频预览图层
@property (nonatomic, strong) AVCaptureVideoDataOutput *dataOutput;
@property (nonatomic, strong) CALayer                  *videoLayer;

@end

@implementation DJIIPhoneCameraViewController

-(instancetype)initWithModel:(DJIIPhoneCameraModel*) model{
    if (self = [super init]) {
        self.cameraModel = model;
        [self initAVCapture];
        [self setUpGesture];
        self.view.backgroundColor = [UIColor blackColor];
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
#if IMAGEOUTPUT
    [self addStillImageOutput];
    [self addPreviewLayer];
#else
    [self addVideoOutput];
    [self addVideoViewLayer];
#endif
    
    [self.session commitConfiguration];
    
    [self getWhiteBalanceArea];
    [self getISOArea];
    [self getShutterArea];
    
    //Preview Layer setup
    
}
#pragma mark- 获取最新数据
-(NSArray*) getWhiteBalanceArea
{
    NSMutableArray *arrayWhiteBalance = [NSMutableArray array];
    for (int i = 2000; i<= 8000; i += 100) {
        [arrayWhiteBalance addObject:@(i)];
    }
    return arrayWhiteBalance;
}

-(NSArray*) getISOArea
{
    AVCaptureDevice *captureDevice = [self _getCurrentDevice];
    AVCaptureDeviceFormat *activeFormat = captureDevice.activeFormat;
    
    NSMutableArray *arrayISO = [NSMutableArray array];
    for (CGFloat i = activeFormat.minISO; i<=activeFormat.maxISO; i+=50) {
        [arrayISO addObject:@(i)];
    }
    return arrayISO;
}

-(NSArray*) getShutterArea
{
    AVCaptureDevice *captureDevice = [self _getCurrentDevice];

    double minDurationSeconds = CMTimeGetSeconds(captureDevice.activeFormat.minExposureDuration);
    double maxDurationSeconds = CMTimeGetSeconds(captureDevice.activeFormat.maxExposureDuration);
   
    NSMutableArray *arrayShutter = [NSMutableArray array];
    for (double i = minDurationSeconds;i < maxDurationSeconds; i += 0.01) {
        [arrayShutter addObject:@(i)];
    }
    return arrayShutter;
}


-(AVCaptureDevice*) _getCurrentDevice
{
    NSArray *inputs = _session.inputs;

    AVCaptureDevice *newCamera = nil;
    for ( AVCaptureDeviceInput *input in inputs ) {
        AVCaptureDevice *device = input.device;
        AVCaptureDevicePosition position = device.position;
            
        if (position == AVCaptureDevicePositionFront)
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
        else
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
    }
    return newCamera;
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
        self.videoLayer.contents = (__bridge_transfer id _Nullable)((cgImage));
    });
}


-(void) takePhoto{
    if (_dataOutput) {
        if (self.ciImage == nil){
            return;
        }
    
        CGImageRef cgImage = [_context createCGImage:_ciImage fromRect:_ciImage.extent];
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithCGImage: cgImage], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }else{
        AVCaptureConnection *videoConnection = [self getOrientationAdaptedCaptureConnection];

        [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:
         ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
             CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
             if (exifAttachments) {
                 //Attachements Found
             } else {
                 //No Attachments
             }
             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
             UIImage *image = [[UIImage alloc] initWithData:imageData];
             UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

        }];
    }

}

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
    [self.videoLayer setFrame:self.view.bounds];
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
    CGAffineTransform t = CGAffineTransformMakeRotation((CGFloat)(-M_PI / 2.0));
    return t;
    
//    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
//    if(orientation == UIDeviceOrientationPortrait) {
//        t = CGAffineTransformMakeRotation((CGFloat)(-M_PI / 2.0));
//    } else if(orientation == UIDeviceOrientationPortraitUpsideDown) {
//        t = CGAffineTransformMakeRotation((CGFloat)(M_PI / 2.0));
//    } else if (orientation == UIDeviceOrientationLandscapeRight) {
//        t = CGAffineTransformMakeRotation((CGFloat)(M_PI));
//    } else if (orientation == UIDeviceOrientationLandscapeLeft){
//        t = CGAffineTransformMakeRotation((CGFloat)(-M_PI));
//
//    }
    
//    else {
//        t = CGAffineTransformMakeRotation(0);
//    }
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

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
//        beginGestureScale = effectiveScale;
//    }
//    return YES;
//}
//
//// scale image depending on users pinch gesture
//- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer
//{
//    BOOL allTouchesAreOnThePreviewLayer = YES;
//    NSUInteger numTouches = [recognizer numberOfTouches], i;
//    for ( i = 0; i < numTouches; ++i ) {
//        CGPoint location = [recognizer locationOfTouch:i inView:self.view];
//        CGPoint convertedLocation = [_previewLayer convertPoint:location fromLayer:_previewLayer.superlayer];
//        if ( ! [_previewLayer containsPoint:convertedLocation] ) {
//            allTouchesAreOnThePreviewLayer = NO;
//            break;
//        }
//    }
//    
//    if ( allTouchesAreOnThePreviewLayer ) {
//        effectiveScale = beginGestureScale * recognizer.scale;
//        CGFloat maxScaleAndCropFactor = [[_dataOutput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];
//        
//        if (effectiveScale < 1.f) {
//            return;
//        }
////        if (effectiveScale > maxScaleAndCropFactor)
////            effectiveScale = 1.f / effectiveScale;
//        
//        NSLog(@"effectiveScale 1:%f ", effectiveScale);
//        
//        
//        [CATransaction begin];
//        [CATransaction setAnimationDuration:.025];
////        [[UIScreen mainScreen] setBrightness:effectiveScale];
//
//        
//        [self.view.layer setAffineTransform:CGAffineTransformMakeScale(effectiveScale, effectiveScale)];
//        [CATransaction commit];
//    }
//}

#pragma orientationAdaptedcapture
- (void)addVideoOutput
{
    _dataOutput = [[AVCaptureVideoDataOutput alloc] init];
    NSDictionary * outputSettings =   [NSDictionary dictionaryWithObject: [NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    _dataOutput.videoSettings = outputSettings;
    _dataOutput.alwaysDiscardsLateVideoFrames = true;
    
    if ([self.session canAddOutput:_dataOutput]) {
        [self.session addOutput:_dataOutput];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL);
    [_dataOutput setSampleBufferDelegate:self queue:queue];
}

- (void)addVideoViewLayer {
    self.videoLayer = [CALayer layer];
    self.videoLayer.anchorPoint = CGPointZero;
    self.videoLayer.bounds = self.view.bounds;

    [self.view.layer insertSublayer:_videoLayer atIndex:0];

    EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSDictionary *options = @{kCIContextWorkingColorSpace :  [NSNull null]};
    _context = [CIContext contextWithEAGLContext:eaglContext options:options];

}

- (void)addStillImageOutput
{
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [_stillImageOutput setOutputSettings:outputSettings];
    
    [self getOrientationAdaptedCaptureConnection];
    
    [_session addOutput:[self stillImageOutput]];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus])
    {
        [device lockForConfiguration:nil];
        [device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [device unlockForConfiguration];
    }
}

- (void)addPreviewLayer {
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    CGRect layerRect = self.view.layer.bounds;
    [self.previewLayer setBounds:layerRect];
    [self.previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
    
    //Apply animation effect to the camera's preview layer
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.6];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [self.previewLayer addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    
    //Add to self.view's layer
    [self.view.layer addSublayer:_previewLayer];

}
- (AVCaptureConnection *)getOrientationAdaptedCaptureConnection
{
    AVCaptureConnection *videoConnection = nil;
    
    for (AVCaptureConnection *connection in [_stillImageOutput connections]) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                [self assignVideoOrienationForVideoConnection:videoConnection];
                break;
            }
        }
        if (videoConnection) {
            [self assignVideoOrienationForVideoConnection:videoConnection];
            break;
        }
    }
    
    return videoConnection;
}

- (void)assignVideoOrienationForVideoConnection:(AVCaptureConnection *)videoConnection
{
    AVCaptureVideoOrientation newOrientation;
    switch ([[UIDevice currentDevice] orientation]) {
        case UIDeviceOrientationPortrait:
            newOrientation = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            newOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        case UIDeviceOrientationLandscapeLeft:
            newOrientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            newOrientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        default:
            newOrientation = AVCaptureVideoOrientationPortrait;
    }
    [videoConnection setVideoOrientation: newOrientation];
}
@end
