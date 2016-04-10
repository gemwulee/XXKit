//
//  OSMOMenuNormaLCell.m
//  XXKit
//
//  Created by tomxiang on 4/7/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOMenuNormaLCell.h"
#import "XXBase.h"
#import "OSMOTableObject.h"
#import "OSMOSwitch.h"
#import "Masonry.h"

@interface OSMOMenuNormaLCell()
@property (strong, nonatomic)  UILabel *titleL;
@property (strong, nonatomic)  UILabel *labelR;
@property (strong, nonatomic)  UIImageView *imageViewR;
@property (strong, nonatomic)  OSMOSwitch *swtichR;
@property (strong, nonatomic)  UIImageView *imageViewIndicator;
@end

@implementation OSMOMenuNormaLCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    UIFont *fontTitle = [UIFont systemFontOfSize:14.f];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleL.textColor = [UIColor whiteColor];
    _titleL.font = fontTitle;
    [self.contentView addSubview:_titleL];
    
    _labelR = [[UILabel alloc] initWithFrame:CGRectZero];
    _labelR.textColor = [UIColor whiteColor];
    _labelR.font = fontTitle;
    [self.contentView addSubview:_labelR];
    
    _imageViewR = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageViewR.contentMode = UIViewContentModeRight;
    [self.contentView addSubview:_imageViewR];

    _swtichR = [[OSMOSwitch alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_swtichR];

    _imageViewIndicator = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageViewIndicator.image = [UIImage imageNamed:@"handleSettingArrow"];
    _imageViewIndicator.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageViewIndicator];

    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(264, 20));
        make.left.equalTo(self.contentView).with.offset(15);
    }];
    
    [_imageViewIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(8, 13));
        make.right.equalTo(self.contentView).with.offset(-5);
    }];
    
    [_labelR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(60, 20.5));
        make.right.equalTo(_imageViewIndicator).with.offset(-10);
    }];
    
    [_imageViewR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.right.equalTo(_imageViewIndicator).with.offset(-13);
    }];
    
    [_swtichR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(49, 31));
        make.right.equalTo(_imageViewIndicator).with.offset(0);
    }];
    

    [_swtichR addTarget:self action:@selector(onSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    
    self.swtichR.hidden = YES;
    self.labelR.hidden = YES;
    self.imageViewR.hidden = YES;
    self.swtichR.hidden = YES;
    self.imageViewIndicator.hidden = YES;
}


- (void)onSwitchValueChange:(UISwitch *)sender {
    weakSelf(target);
    if (self.clickSwitchButtonCell) {
        weakReturn(target);
        self.clickSwitchButtonCell(self,sender.isOn);
    }
}

-(void) configureData:(OSMOTableObject*) settingObject
{
    self.titleL.text = LOCALIZE(settingObject.titleL);
    
    if(settingObject.labelR.length > 0){
        self.labelR.text = LOCALIZE(settingObject.labelR);
        self.labelR.hidden = NO;
    }else{
        self.labelR.hidden = YES;
    }
    
    if(settingObject.imageViewR.length > 0){
        self.imageViewR.image = [UIImage imageNamed:settingObject.imageViewR];
        self.imageViewR.hidden = NO;
    }else{
        self.imageViewR.hidden = YES;
    }
    
    
    self.swtichR.hidden = !settingObject.swtichR;
    self.imageViewIndicator.hidden = !settingObject.showRightSideImage;
}

-(void) setSwitchOn:(BOOL) isOn
{
    [self.swtichR setOn:isOn];
}

-(void) setCellSelected:(BOOL)selected
{
    self.imageViewIndicator.hidden = !selected;
    
    if (selected) {
        self.imageViewIndicator.image = [UIImage imageNamed:@"handlePickerMidArrow"];
    }
}
@end
