//
//  OSMOMenuViewBaseController.m
//  XXKit
//
//  Created by tomxiang on 4/1/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOMenuViewBaseController.h"
#import "Masonry.h"
#import <UIKit/UIKit.h>
#import "XXBase.h"

@interface OSMOMenuViewBaseController()
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UILabel *labelCustom;
@property(nonatomic,strong) UIButton* backButton;

@end

@implementation OSMOMenuViewBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, OSMO_NAV_HEIGHT)];
    [_navView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_navView];
    
    _labelCustom = [[UILabel alloc] initWithFrame:CGRectZero];
    _labelCustom.font = [UIFont systemFontOfSize:16.f];
    _labelCustom.textColor = [UIColor whiteColor];
    _labelCustom.text = @"默认标题";
    _labelCustom.textAlignment = NSTextAlignmentCenter;
   [_navView addSubview:_labelCustom];
                         
    [_labelCustom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_navView);
        make.height.equalTo(_navView);
        make.width.equalTo(_navView).offset(_navView.width - OSMO_NAV_HEIGHT * 2);
    }];
    
    
    UIImage* image= [UIImage imageNamed:@"back_arrow"];
    CGRect backframe= CGRectMake(0, 0, OSMO_NAV_HEIGHT, image.size.height);
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = backframe;
    
    [_backButton setBackgroundImage:image forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backButton];
    
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_navView);
        make.left.equalTo(_navView).with.offset(10);
    }];
    

    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, OSMO_NAV_HEIGHT, self.view.width, self.view.height - OSMO_NAV_HEIGHT)];
    [_mainView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_mainView];
    
}

#pragma mark - BarButton Pressed

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _navView.frame = CGRectMake(0, 0, self.view.width, OSMO_NAV_HEIGHT);
    _mainView.frame = CGRectMake(0, OSMO_NAV_HEIGHT, self.view.width, self.view.height - OSMO_NAV_HEIGHT);
    
    if (self.navigationController.viewControllers.count > 1) {
        _backButton.hidden = NO;
    }else{
        _backButton.hidden = YES;
    }
    

}

-(void)popself{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) setTextTitle:(NSString*) title
{
    self.labelCustom.text = title;
}
@end
