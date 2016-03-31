//
//  DJIIPhoneCameraView.m
//  Phantom3
//
//  Created by tomxiang on 3/24/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import "DJIIPhoneCameraView.h"
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>
#import "DJICameraIPhoneHandler.h"
#import "DJIIPhoneCameraModel.h"

@interface DJIIPhoneCameraView()<AVCaptureVideoDataOutputSampleBufferDelegate,UIGestureRecognizerDelegate>
{
    CGFloat beginGestureScale;
    CGFloat effectiveScale;

}

@property (nonatomic, strong) DJICameraIPhoneHandler *handler;
@property (nonatomic, strong) AVCaptureSession       *session;           //AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) CALayer                *previewLayer;      //预览图层，来显示照相机拍摄到的画面

@property (nonatomic, strong) CIFilter               *filter;            //滤镜
@property (nonatomic, strong) CIContext              *context;
@property (nonatomic, strong) NSArray                *filterNames;
@property (nonatomic, strong) CIImage                *ciImage;

@property (nonatomic, strong) AVCaptureVideoDataOutput *dataOutput;
@end

@implementation DJIIPhoneCameraView

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model{
    self.backgroundColor = [UIColor yellowColor];
    if (self = [super initWithFrame:frame]) {
        self.cameraModel = model;
        [self initData];
        [self initCamera];
        [self initEvent];
        [self setUpGesture];
    }
    return self;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark- 初始化数据
- (void) initData{
    self.handler = [[DJICameraIPhoneHandler alloc] initWithCameraView:self];
    [self initSesstion];
}

-(void) initCamera{
    [self initCIFilter];
    
    self.previewLayer = [CALayer layer];
    self.previewLayer.anchorPoint = CGPointZero;
    self.previewLayer.bounds = self.bounds;
    [self.layer insertSublayer:_previewLayer atIndex:0];
}

-(void)initSesstion{
    self.session = [AVCaptureSession new];
    [self.session beginConfiguration];
    self.session.sessionPreset = AVCaptureSessionPresetHigh;//AVCaptureSessionPreset3840x2160;
    
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
    
}
//滤镜
-(void) initCIFilter{
    //    self.filter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
    EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSDictionary *options = @{kCIContextWorkingColorSpace :  [NSNull null]};
    self.context = [CIContext contextWithEAGLContext:eaglContext options:options];
}

-(void) initEvent{
    //    @weakify(self);
    //    self.cameraShowView.selectBlock = ^(NSInteger row){
    //        @strongify(self)
    //        NSLog(@"row:%ld",row);
    //        NSString *filterName = [self.filterNames objectAtIndex:row];
    //        self.filter = [CIFilter filterWithName:filterName];
    //    };
}

#pragma mark- 摄像头
- (AVCaptureDevice *)frontCamera {
    return [self.handler cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera {
    return [self.handler cameraWithPosition:AVCaptureDevicePositionBack];
}


#pragma mark- capture delegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage *outputImage = [[CIImage alloc]initWithCVPixelBuffer:imageBuffer];
    
    if(_filter != nil){
        [self.filter setValue:outputImage forKey:kCIInputImageKey];
        outputImage = _filter.outputImage;
    }
    
    outputImage = [outputImage imageByApplyingTransform:[self.handler getCameraTransform]];
    
    CGImageRef cgImage = [_context createCGImage:outputImage fromRect:outputImage.extent];
    self.ciImage = outputImage;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.previewLayer.contents = (__bridge_transfer id _Nullable)((cgImage));
    });
}

#pragma mark- 旋转，重置frame
-(void) resetCameraFrame:(CGRect) bounds{
    self.frame = bounds;
    [self.previewLayer setFrame:self.bounds];
}

#pragma mark- Handler事件
-(void) openCamera{
    [self.handler openCamera:_session];
}

-(void) closeCamera{
    [self.handler closeCamera:_session];
    
}

-(void) takePhoto{
    [self.handler takePhoto:self.ciImage context:self.context];
}


#pragma mark- 根据model刷新参数
-(void) reloadSkins
{
    
}

-(void) swapFrontAndBackCameras
{
    [self.handler swapFrontAndBack:_session];
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
    [self addGestureRecognizer:pinch];
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
        CGPoint location = [recognizer locationOfTouch:i inView:self];
        CGPoint convertedLocation = [_previewLayer convertPoint:location fromLayer:_previewLayer.superlayer];
        if ( ! [_previewLayer containsPoint:convertedLocation] ) {
            allTouchesAreOnThePreviewLayer = NO;
            break;
        }
    }
    
    if ( allTouchesAreOnThePreviewLayer ) {
        effectiveScale = beginGestureScale * recognizer.scale;
        
//        NSLog(@"effectiveScale0:%f",effectiveScale);

        
//        if (effectiveScale < 1.0)
//            effectiveScale = 1.0;
        CGFloat maxScaleAndCropFactor = [[_dataOutput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];

        
        if (effectiveScale > maxScaleAndCropFactor)
            effectiveScale = 1.f / effectiveScale;
        
        NSLog(@"effectiveScale 1:%f ", effectiveScale);

        
        [CATransaction begin];
        [CATransaction setAnimationDuration:.025];
        
        [_previewLayer setAffineTransform:CGAffineTransformMakeScale(effectiveScale, effectiveScale)];
        [CATransaction commit];
    }
}
@end
