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

@interface DJIIPhoneCameraView()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) DJICameraIPhoneHandler *handler;
@property (nonatomic, strong) AVCaptureSession       *session;           //AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong) CALayer                *previewLayer;      //预览图层，来显示照相机拍摄到的画面

@property (nonatomic, strong) CIFilter               *filter;            //滤镜
@property (nonatomic, strong) CIContext              *context;
@property (nonatomic, strong) NSArray                *filterNames;
@property (nonatomic, strong) CIImage                *ciImage;
@end

@implementation DJIIPhoneCameraView

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model{
    if (self = [super initWithFrame:frame]) {
        self.cameraModel = model;
        [self initData];
        [self initCamera];
        [self initEvent];
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


@end
