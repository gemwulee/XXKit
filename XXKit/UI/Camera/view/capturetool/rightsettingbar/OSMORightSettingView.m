//
//  OSMORightSettingView.m
//  XXKit
//
//  Created by tomxiang on 3/30/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMORightSettingView.h"
#import "OSMOStateButton.h"
#import "UIView+Common.h"
#import "UIDevice+DJIUIKit.h"
#import "OSMOEventAction.h"
#define BUTTONSum (5)

@interface  OSMORightSettingView()
@property (strong, nonatomic)  OSMOStateButton *homeButton;
@property (strong, nonatomic)  OSMOStateButton *blankButton;
@property (strong, nonatomic)  OSMOStateButton *cameraButton;
@property (strong, nonatomic)  OSMOStateButton *gimbalButton;
@property (strong, nonatomic)  OSMOStateButton *settingButton;

@property (strong, nonatomic)  NSMutableArray *arrayButtons;

@end



@implementation OSMORightSettingView

-(void) initData{
    _arrayButtons = [NSMutableArray array];
}

-(void) initViews
{
    _homeButton =[[OSMOStateButton alloc] initWithFrame:CGRectZero];
    [_homeButton setStateIconNormal:@"handleHomeOff" iconSelected:@"handleHomeOn"];
    
    _blankButton = [[OSMOStateButton alloc] initWithFrame:CGRectZero];
    _blankButton.backgroundColor = [UIColor clearColor];
    
    _cameraButton =[[OSMOStateButton alloc] initWithFrame:CGRectZero];
    [_cameraButton setStateIconNormal:@"handleMenuCamOff" iconSelected:@"handleMenuCamOn"];
    
    _gimbalButton =[[OSMOStateButton alloc] initWithFrame:CGRectZero];
    [_gimbalButton setStateIconNormal:@"handleMenuGimbalOff" iconSelected:@"handleMenuGimbalOn"];

    _settingButton =[[OSMOStateButton alloc] initWithFrame:CGRectZero];
    [_settingButton setStateIconNormal:@"handleSettingOff" iconSelected:@"handleSettingOn"];
    
    [_arrayButtons addObject:_homeButton];
    [_arrayButtons addObject:_blankButton];
    [_arrayButtons addObject:_cameraButton];
    [_arrayButtons addObject:_gimbalButton];
    [_arrayButtons addObject:_settingButton];
    
    for(OSMOStateButton *button in _arrayButtons){
        [self addSubview:button];

    }
}

-(void) initEvent
{
    [_homeButton addTarget:self action:@selector(clickHandleHomeButton:) forControlEvents:UIControlEventTouchUpInside];
    [_cameraButton addTarget:self action:@selector(clickHandleCameraButton:) forControlEvents:UIControlEventTouchUpInside];
    [_gimbalButton addTarget:self action:@selector(clickHandleGimbalButton:) forControlEvents:UIControlEventTouchUpInside];
    [_settingButton addTarget:self action:@selector(clickSettingButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) layoutLandscape
{
    int divideHeight = self.height / BUTTONSum;

    _homeButton.frame     = CGRectMake(0, 0, self.width, divideHeight);
    _blankButton.frame    = CGRectMake(0, _homeButton.bottom, self.width, divideHeight);
    _cameraButton.frame   = CGRectMake(0, _blankButton.bottom, self.width, divideHeight);
    _gimbalButton.frame   = CGRectMake(0, _cameraButton.bottom, self.width, divideHeight);
    _settingButton.frame  = CGRectMake(0, _gimbalButton.bottom, self.width, divideHeight);
}

-(void) layoutPortrait
{
    int divideWidth = self.width / BUTTONSum;
    
    _homeButton.frame     = CGRectMake(0, 0, divideWidth, self.height);
    _blankButton.frame    = CGRectMake(_homeButton.right,   0, divideWidth, self.height);
    _cameraButton.frame   = CGRectMake(_blankButton.right,  0, divideWidth, self.height);
    _gimbalButton.frame   = CGRectMake(_cameraButton.right, 0, divideWidth, self.height);
    _settingButton.frame  = CGRectMake(_gimbalButton.right, 0, divideWidth, self.height);
}
-(void) refreshViewForIPhoneCameraMode{}

-(void) restoreDefaultStatus{
    for(OSMOStateButton *button in self.arrayButtons){
        if(button.selected == YES){
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark- Button Click
- (void)clickHandleHomeButton:(id)sender{
    [self.cameraAction actionClick_HomeButton_OSMORightSettingView:sender];
    [self updateCameraStatus:sender];
}

- (void)clickHandleCameraButton:(id)sender{
    [self.cameraAction actionClick_CameraButton_OSMORightSettingView:sender];
    [self updateCameraStatus:sender];
}

-(void)clickHandleGimbalButton:(id)sender{
    [self.cameraAction actionClick_GimbalButton_OSMORightSettingView:sender];
    [self updateCameraStatus:sender];
}

-(void)clickSettingButton:(id)sender{
    [self.cameraAction actionClick_SettingButton_OSMORightSettingView:sender];
    [self updateCameraStatus:sender];
}

-(void) updateCameraStatus:(id) sender
{
    for(OSMOStateButton *button in self.arrayButtons){
        if(button != sender){
            button.selected = FALSE;
        }
    }
}


@end
