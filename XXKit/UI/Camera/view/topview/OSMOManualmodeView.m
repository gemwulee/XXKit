//
//  OSMOManualmodeView.m
//  XXKit
//
//  Created by tomxiang on 4/7/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOManualmodeView.h"
#import "OSMOManualView.h"
#import "Masonry.h"
#import "XXBase.h"

@interface OSMOManualmodeView()

@property(nonatomic,strong) OSMOManualView *manualViewISO;
@property(nonatomic,strong) OSMOManualView *manualViewShutter;
@property(nonatomic,strong) OSMOManualView *manualViewWhiteBalance;

@end


@implementation OSMOManualmodeView

- (void)initData{}
- (void)initViews
{
    self.backgroundColor = [UIColor blackColor];
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
    self.alpha = 0.5f;
    
    _manualViewISO = [[OSMOManualView alloc] initWithFrame:CGRectZero];
    [_manualViewISO setLabelTipText:@"ISO"];
    [_manualViewISO setLabelContentText:@"200"];
    
    _manualViewShutter = [[OSMOManualView alloc] initWithFrame:CGRectZero];
    [_manualViewShutter setLabelTipText:@"sec"];
    [_manualViewShutter setLabelContentText:@"1/4"];

    _manualViewWhiteBalance = [[OSMOManualView alloc] initWithFrame:CGRectZero];
    [_manualViewWhiteBalance setLabelTipText:@"WB"];
    [_manualViewWhiteBalance setLabelContentText:@"3000K"];
    
//    _manualViewShutter.backgroundColor = [UIColor grayColor];
//    _manualViewISO.backgroundColor = [UIColor greenColor];

    [self addSubview:_manualViewISO];
    [self addSubview:_manualViewShutter];
    [self addSubview:_manualViewWhiteBalance];
    
    [_manualViewISO mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1.f/3);
        make.left.mas_equalTo(self.mas_left).with.offset(5.f);
    }];
    
    [_manualViewShutter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.width.equalTo(_manualViewISO);
        make.left.mas_equalTo(_manualViewISO.mas_right).with.offset(0);
    }];
    
    
    [_manualViewWhiteBalance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.width.equalTo(_manualViewISO);
        make.left.mas_equalTo(_manualViewShutter.mas_right).with.offset(0);
    }];
    

}

- (void)initEvent{
    UITapGestureRecognizer *tapGestureISO = [[UITapGestureRecognizer alloc]initWithTarget:self.cameraAction  action:@selector(actionClick_ISO_OSMOManualmodeView:)];
    [_manualViewISO addGestureRecognizer:tapGestureISO];
    
    UITapGestureRecognizer *tapGestureShutter = [[UITapGestureRecognizer alloc]initWithTarget:self.cameraAction  action:@selector(actionClick_Shutter_OSMOManualmodeView:)];
    [_manualViewShutter addGestureRecognizer:tapGestureShutter];
    
    UITapGestureRecognizer *tapGestureWhiteBalance = [[UITapGestureRecognizer alloc]initWithTarget:self.cameraAction  action:@selector(actionClick_WhiteBalance_OSMOManualmodeView:)];
    [_manualViewWhiteBalance addGestureRecognizer:tapGestureWhiteBalance];
}

- (void)layoutLandscape{}
- (void)layoutPortrait{}
- (void)refreshViewForIPhoneCameraMode{}
- (void)restoreDefaultStatus{}
@end
