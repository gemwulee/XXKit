//
//  OSMOSwitchView.m
//  XXKit
//
//  Created by tomxiang on 3/28/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOSwitchView.h"
#import "Masonry.h"
#import "DJIIPhoneCameraModel.h"
#import "OSMOCaptureToolView.h"
#import "UIDevice+DJIUIKit.h"
#import "UIView+Common.h"
#import "OSMOCaptureToolView.h"

@interface OSMOSwitchView()
@property(nonatomic,strong) UIImageView *imageViewBg;           //灰色背景
@property(nonatomic,strong) UIImageView *imageViewPhoto;
@property(nonatomic,strong) UIImageView *imageViewVideo;

@property(nonatomic,strong) UIImageView *iconView;                  //Switch开关,小圆按钮

@property(nonatomic,strong) UIButton *buttonPhoto;                  //clear,为了增大点击区域
@property(nonatomic,strong) UIButton *buttonVideo;


//UISwitch
@property (strong,nonatomic) UIPanGestureRecognizer *panGesture;    //滑动切换
@property (strong,nonatomic) UITapGestureRecognizer *tapGesture;    //点击进行切换

@property (assign,nonatomic) DJIIPhoneCameraMode tempCaptureMode;

@end


@implementation OSMOSwitchView

-(void)initData{}
-(void)initViews
{
    self.tempCaptureMode = self.cameraModel.captureMode;
    
    _imageViewBg = [[UIImageView alloc] init];
    _imageViewPhoto = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:@"handleCamModeOn"]];
    _imageViewVideo = [[UIImageView alloc] init];//WithImage:@"handleVideoModeOff"]];
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"handleSwitchIcon"]];
    _iconView.frame = CGRectZero;
    
    [self addSubview:_imageViewBg];
    
    [_imageViewBg addSubview:_iconView];
    [_imageViewBg addSubview:_imageViewPhoto];
    [_imageViewBg addSubview:_imageViewVideo];
    
    _imageViewPhoto.contentMode = UIViewContentModeScaleAspectFill;
    _imageViewVideo.contentMode = UIViewContentModeScaleAspectFill;
    
    _imageViewVideo.size = _imageViewPhoto.size = (CGSizeMake(OSMOSwitchView_PHOTO_IMAGE_WIDTH, OSMOSwitchView_PHOTO_IMAGE_HEIGHT));
    
    _buttonPhoto = [[UIButton alloc] initWithFrame:CGRectZero];
    _buttonVideo = [[UIButton alloc] initWithFrame:CGRectZero];
    
    //    [self addSubview:_buttonPhoto];
    //    [self addSubview:_buttonVideo];
    
    [self reloadSkins];
    [self initGesture];
}
-(void)initEvent{}
-(void) layoutLandscape
{
    [_buttonPhoto setFrame:CGRectMake(0, 0, self.width,self.height/2)];
    [_buttonVideo setFrame:CGRectMake(0, _buttonPhoto.bottom, self.width, self.height/2)];
    
    _imageViewBg.image = [UIImage imageNamed:@"handleLandscapeSwitchBg"];
    [_imageViewBg setFrame:CGRectMake(OSMOSwitchView_Y, 0, self.width/2, self.height)];
    
    [_imageViewPhoto setOrigin:CGPointMake((_imageViewBg.width - OSMOSwitchView_PHOTO_IMAGE_WIDTH)/2,OSMOSwitchView_ImageViewPhoto_Landscape_Y)];
    [_imageViewVideo setOrigin:CGPointMake(_imageViewPhoto.x, OSMOSwitchView_ImageViewVideo_Landscape_Y)];
    
    //--隔离动画--
    switch (self.cameraModel.captureMode) {
        case DJIIPhone_PhotoModel:
        {
            [_iconView setFrame:CGRectMake(0, 0, _imageViewBg.width, _imageViewBg.height/2)];
        }
            break;
        case DJIIPhone_VideoModel:
        {
            [_iconView setFrame:CGRectMake(0, _imageViewBg.height/2, _imageViewBg.width, _imageViewBg.height/2)];
        }
            break;
    }
}

-(void) layoutPortrait
{
    [_buttonPhoto setFrame:CGRectMake(0, 0, self.width/2,self.height)];
    [_buttonVideo setFrame:CGRectMake(_buttonPhoto.right, 0,self.width/2, self.height)];
    
    _imageViewBg.image = [UIImage imageNamed:@"handlePotraitSwitchBg"];
    [_imageViewBg setFrame:CGRectMake(0, OSMOSwitchView_Y, self.width, (self.height-OSMOSwitchView_Y*2))];
    
    [_imageViewPhoto setOrigin:CGPointMake(OSMOSwitchView_ImageViewPhoto_Portrait_Y, (_imageViewBg.height - OSMOSwitchView_PHOTO_IMAGE_HEIGHT)/2)];
    [_imageViewVideo setOrigin:CGPointMake(OSMOSwitchView_ImageViewVideo_Portrait_Y, _imageViewPhoto.y)];
    
    switch (self.cameraModel.captureMode) {
        case DJIIPhone_PhotoModel:
        {
            [_iconView setFrame:CGRectMake(0, 0, _imageViewBg.width/2, _imageViewBg.height)];
        }
            break;
        case DJIIPhone_VideoModel:
        {
            [_iconView setFrame:CGRectMake(_imageViewBg.width/2, 0, _imageViewBg.width/2, _imageViewBg.height)];
        }
            break;
    }
}
-(void) refreshViewForIPhoneCameraMode{
    switch (self.cameraModel.captureMode) {
        case DJIIPhone_PhotoModel:
        {
            _imageViewPhoto.image = [UIImage imageNamed:@"handleCamModeOn"];
            _imageViewVideo.image = [UIImage imageNamed:@"handleVideoModeOff"];
        }
            break;
        case DJIIPhone_VideoModel:
        {
            _imageViewPhoto.image = [UIImage imageNamed:@"handleCamModeOff"];
            _imageViewVideo.image = [UIImage imageNamed:@"handleVideoModeOn"];
        }
            break;
        default:
            break;
    }
}
-(void) restoreDefaultStatus{}
#pragma mark- Event
-(void) initGesture
{
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [self addGestureRecognizer:_panGesture];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self addGestureRecognizer:_tapGesture];
}

#pragma mark- Gesture

- (void)tapGestureAction:(UITapGestureRecognizer *)sender{
    
    if(sender.state == UIGestureRecognizerStateEnded){
        
        CGPoint touchPoint = [sender locationInView:self];
        
        CGFloat moveCenterX = touchPoint.x;
        CGFloat moveCenterY = touchPoint.y;
        
        [self setIconViewAnimation:CGPointMake(moveCenterX, moveCenterY)];
    }
}


- (void)panGestureAction:(UIPanGestureRecognizer *)sender{
    
    CGPoint movePoint = [sender translationInView:self];
    CGFloat moveCenterX = _iconView.center.x;
    CGFloat moveCenterY = _iconView.center.y;
    
    if([UIDevice isLandscape]){
        switch (self.cameraModel.captureMode) {
            case DJIIPhone_PhotoModel:
            {
                moveCenterY = _iconView.frame.size.height*0.5 + movePoint.y;
            }
                break;
            case DJIIPhone_VideoModel:
            {
                moveCenterY = self.frame.size.height - _iconView.frame.size.height*0.5 + movePoint.y;
            }
                break;
        }
        moveCenterY = [self restrainValue:moveCenterY withMin:_iconView.frame.size.height*0.5 withMax:self.frame.size.height - _iconView.frame.size.height*0.5];
    }
    else{
        switch (self.cameraModel.captureMode) {
            case DJIIPhone_PhotoModel:
            {
                moveCenterX = _iconView.frame.size.width*0.5 + movePoint.x;
            }
                break;
            case DJIIPhone_VideoModel:
            {
                moveCenterX = self.frame.size.width - _iconView.frame.size.width*0.5 + movePoint.x;
            }
                break;
        }
        moveCenterX = [self restrainValue:moveCenterX withMin:_iconView.frame.size.width*0.5 withMax:self.frame.size.width - _iconView.frame.size.width*0.5];
    }
    
    [_iconView setCenter:CGPointMake(moveCenterX, moveCenterY)];
    
    if(sender.state == UIGestureRecognizerStateEnded){
        [self setIconViewAnimation:CGPointMake(_iconView.centerX, _iconView.centerY)];
    }
}

- (BOOL)checkIsOn{
    if(![UIDevice isLandscape]){
        return _iconView.center.x > self.centerX;
    }
    else{
        return _iconView.center.y > self.centerY;
    }
}

- (CGFloat)restrainValue:(CGFloat)value withMin:(CGFloat)min withMax:(CGFloat)max{
    if(value<min) return min;
    else if (value>max) return max;
    else return value;
}

- (BOOL)isHorizon{
    return self.frame.size.height<=self.frame.size.width;
}

-(void) setIconViewAnimation:(CGPoint) currentPoint
{
    CGPoint resultPoint = [self getResultPoint:currentPoint];
    
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.iconView.origin = resultPoint;
        
    } completion:^(BOOL finished) {
        
        self.iconView.origin = resultPoint;
        
        if(self.cameraModel.captureMode != self.tempCaptureMode){
            self.cameraModel.captureMode = self.tempCaptureMode;
        }
    }];
    
}

-(CGPoint) getResultPoint:(CGPoint) current
{
    CGPoint resultPoint = CGPointZero;
    if([UIDevice isLandscape]){
        if(current.y > _imageViewBg.centerY){
            resultPoint = CGPointMake(0, _imageViewBg.height/2);
            self.tempCaptureMode = DJIIPhone_VideoModel; //下面是摄影模式
        }else{
            resultPoint = CGPointMake(0, 0);
            self.tempCaptureMode = DJIIPhone_PhotoModel; //上面是拍照模式
        }
    }else{
        if(current.x > _imageViewBg.centerX){
            resultPoint = CGPointMake( _imageViewBg.width/2,0);
            self.tempCaptureMode = DJIIPhone_VideoModel; //右边是摄影模式
        }else{
            resultPoint = CGPointMake(0, 0);
            self.tempCaptureMode = DJIIPhone_PhotoModel;//左边是摄影模式
        }
    }
    return resultPoint;
}
@end
