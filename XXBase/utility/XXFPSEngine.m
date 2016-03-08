//
//  XXFPSEngine.m
//  XXBase
//
//  Created by tomxiang on 16/2/27.
//  Copyright © 2016年 tomxiang. All rights reserved.
//  https://github.com/RolandasRazma/RRFPSBar
//  http://www.jianshu.com/p/c35a81c3b9eb

#import "XXFPSEngine.h"
#import "UIScreenEx.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

#define kSize CGSizeMake(55, 20)

@interface XXFPSEngine()
@property(nonatomic,strong) CADisplayLink *disLink;
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,assign) NSInteger count;
@property(nonatomic,assign) NSTimeInterval lastTime;
@end

@implementation XXFPSEngine

+(XXFPSEngine *)sharedInstance
{
    static XXFPSEngine *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[XXFPSEngine alloc] init];
    });
    return _sharedInstance;
}

-(instancetype)init
{
    if (self = [super init]) {
//        if([[UIDevice currentDevice].systemVersion floatValue] >= 9.0){
//            self.rootViewController = [UIViewController new];
//        }
        self.backgroundColor = [UIColor clearColor];
        [self setWindowLevel:UIWindowLevelAlert + 10000000];
        self.frame = CGRectMake(10, SCREEN_HEIGHT - kSize.height - 44 - 10 , kSize.width, kSize.height);
//        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        _disLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(disTick:)];
        [_disLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        [self initLabel];
    }
    return self;
}

-(void) initLabel
{
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0 , 0, kSize.width, kSize.height)];
    _label.layer.cornerRadius = 5;
    _label.clipsToBounds = YES;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.userInteractionEnabled = NO;
    _label.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    [self setLabelText:@"60"];
    _label.font = [UIFont fontWithName:@"Menlo" size:14];;
    _label.textColor = [UIColor whiteColor];
    [self addSubview:_label];
}
-(void) setLabelText:(NSString*) fps
{
    _label.text = [NSString stringWithFormat:@"%@ FPS",fps];

}
- (void)dealloc {
    [_disLink setPaused:YES];
    [_disLink invalidate];
    [_disLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

//通常来讲：iOS设备的刷新频率事60HZ也就是每秒60次。那么每一次刷新的时间就是1/60秒 大概16.7毫秒
-(void) disTick:(CADisplayLink *)link
{
    if(_lastTime == 0){
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if(delta < 1)
        return;
    
    _lastTime = link.timestamp;
//    NSLog(@"%zd %lf",_count,delta);
    float fps = _count / delta;
    _count = 0;
    
    [self setLabelText:[NSString stringWithFormat:@"%d",(int)round(fps)]];
}

-(void) startMonistor
{
    _disLink.paused = NO;
    [self setHidden:NO];
}

-(void) endMonistor
{
    _disLink.paused = YES;
    [self setHidden:YES];
}



@end