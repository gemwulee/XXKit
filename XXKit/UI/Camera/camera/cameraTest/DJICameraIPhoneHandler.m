//
//  DJICameraIPhoneHandler.m
//  Phantom3
//
//  Created by tomxiang on 3/24/16.
//  Copyright © 2016 DJIDevelopers.com. All rights reserved.
//

#import "DJICameraIPhoneHandler.h"
#import "DJIIPhoneCameraView.h"

@interface DJICameraIPhoneHandler()
@property(nonatomic,weak) DJIIPhoneCameraView *cameraView;
@end


@implementation DJICameraIPhoneHandler

-(instancetype)initWithCameraView:(DJIIPhoneCameraView*) cameraView
{
    if(self = [super init]){
        self.cameraView = cameraView;
    }
    return self;
}

//打开相机
-(void) openCamera:(AVCaptureSession*) session
{
    if (session) {
        [session startRunning];
    }
}

//关闭相机
-(void) closeCamera:(AVCaptureSession*) session
{
    if (session) {
        [session stopRunning];
    }
}

//切换摄像头
-(void) swapFrontAndBack:(AVCaptureSession*) session{
    NSArray *inputs = session.inputs;
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
            [session beginConfiguration];
            
            [session removeInput:input];
            [session addInput:newInput];
            
            // Changes take effect once the outermost commitConfiguration is invoked.
            [session commitConfiguration];
            break;
        }
    }
}

//应用摄像头
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            //设置device属性 曝光档数
            NSLog(@"曝光档书: min:%lf max:%lf",device.minExposureTargetBias,device.maxExposureTargetBias);
            //ISO
            AVCaptureDeviceFormat *avFormat = device.activeFormat;
            NSLog(@"ISO: min:%lf max:%lf",avFormat.minISO,avFormat.maxISO);
            //曝光时间
            //NSLog(@"曝光时间: min:%@ max:%@",avFormat.minExposureDuration,avFormat.maxExposureDuration);
            
            return device;
        }
    }
    return nil;
}

#pragma mark- 拍照
- (void)takePhoto:(CIImage*) ciImage context:(CIContext*) context{
    
    if (ciImage == nil){
        return;
    }
    
    CGImageRef cgImage = [context createCGImage:ciImage fromRect:ciImage.extent];
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithCGImage: cgImage], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
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
#pragma mark- Video Name
-(NSString*) getVideoFileName
{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    
    NSString *fileName = [NSString stringWithFormat:@"%zd%zd%zd%zd%zd%zd",year,month,day,hour,minute,second];
    return fileName;
}

@end
