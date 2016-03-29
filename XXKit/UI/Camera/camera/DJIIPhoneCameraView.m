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

@interface DJIIPhoneCameraView()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, strong) DJICameraIPhoneHandler *handler;
@property (nonatomic, strong) AVCaptureSession       *session;           //AVCaptureSession对象来执行输入设备和输出设备之间的数据传递

//相机CALayer
@property (nonatomic, strong) CALayer     *previewLayer;      //预览图层，来显示照相机拍摄到的画面
@property (nonatomic, strong) AVCaptureDeviceInput          *videoInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput      *dataOutput;
@property (nonatomic, strong) CIFilter               *filter;            //滤镜
@property (nonatomic, strong) CIContext              *context;
@property (nonatomic, strong) NSArray                *filterNames;
@property (nonatomic, strong) CIImage                *ciImage;

//视频
@property (nonatomic, strong) AVCaptureMovieFileOutput      *movieFileOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer    *videoLayer;      //预览图层，来显示照相机拍摄到的画面


@end

@implementation DJIIPhoneCameraView

-(instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model{
    if (self = [super initWithFrame:frame]) {
        self.cameraModel = model;
        [self initData];
        
        [self startInitPhotoAndVideoPub];
        [self initShowLayer];
        [self setVideoSessionOutput];

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

}

-(void) startInitPhotoAndVideoPub
{
    self.session = [AVCaptureSession new];
    [self.session beginConfiguration];
    self.session.sessionPreset = AVCaptureSessionPresetHigh;//AVCaptureSessionPreset3840x2160;
    
    //AVCaptureDeviceInput对象是输入流
    AVCaptureDevice *device = (self.cameraModel.devicePosition == DJIIPhone_DevicePositionFront)?[self frontCamera]:[self backCamera];
    _videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    
    if ([self.session canAddInput:_videoInput]) {
        [self.session addInput:_videoInput];
    }
    
    _dataOutput = [[AVCaptureVideoDataOutput alloc] init];
    NSDictionary * outputSettings =   [NSDictionary dictionaryWithObject: [NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    _dataOutput.videoSettings = outputSettings;
    _dataOutput.alwaysDiscardsLateVideoFrames = true;
    
    _movieFileOutput = [AVCaptureMovieFileOutput new];
    // 增加声音录制
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput * audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
    [_session addInput:audioInput];
    
    [self.session commitConfiguration];
}

-(void) initShowLayer
{
    _videoLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    _videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _videoLayer.frame = self.bounds;
    
    _previewLayer = [CALayer layer];
    _previewLayer.anchorPoint = CGPointZero;
    _previewLayer.bounds = self.bounds;
}

-(void)setPhotoSesstionOutput
{
    [self.session beginConfiguration];
    
    [self.layer insertSublayer:_previewLayer atIndex:0];

    [self initCIFilter];
    if ([self.session canAddOutput:_dataOutput]) {
        [self.session addOutput:_dataOutput];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL);
    [_dataOutput setSampleBufferDelegate:self queue:queue];
    
    [self.session commitConfiguration];
}

-(void)setVideoSessionOutput
{
    [self.session beginConfiguration];
    
    [self.layer insertSublayer:_videoLayer atIndex:0];

    if([_session canAddOutput:_movieFileOutput]){
        [_session addOutput:_movieFileOutput];
    }

    AVCaptureConnection *captureConnection = [_movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    // 开启视频防抖模式
    AVCaptureVideoStabilizationMode stabilizationMode = AVCaptureVideoStabilizationModeCinematic;
    if ([_videoInput.device.activeFormat isVideoStabilizationModeSupported:stabilizationMode]) {
        [captureConnection setPreferredVideoStabilizationMode:stabilizationMode];
    }
    
    [self.session commitConfiguration];

}

//滤镜
-(void) initCIFilter{
//    self.filter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
    EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSDictionary *options = @{kCIContextWorkingColorSpace :  [NSNull null]};
    if (!self.context) {
        self.context = [CIContext contextWithEAGLContext:eaglContext options:options];
    }
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

-(void) startRecordVideo{
    NSString *outputFilePath = [NSTemporaryDirectory() stringByAppendingString:[self.handler getVideoFileName]];
    NSURL *fileUrl = [NSURL fileURLWithPath:outputFilePath];
    [_movieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
}

-(void) stopRecordVideo{
    [_movieFileOutput stopRecording];
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    NSLog(@"---- 开始录制 ----");
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    NSLog(@"---- 录制结束 ----");
}

#pragma mark- 根据model刷新参数
-(void) reloadSkins
{
    switch (self.cameraModel.captureMode) {
        case DJIIPhone_PhotoModel:
        {
            [self setPhotoSesstionOutput];
        }
            break;
        case DJIIPhone_VideoModel:
        {
            [self setVideoSessionOutput];
        }
            break;
        default:
            break;
    }
}

#pragma mark- 切换摄像头
- (void)swapFrontAndBackCameras {
    // Assume the session is already running
    [self.handler swapFrontAndBack:self.session];
}

@end
