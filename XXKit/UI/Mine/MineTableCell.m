//
//  MineTableCell.m
//  XXKit
//
//  Created by tomxiang on 16/3/5.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "MineTableCell.h"
#import "XXGlobalColor.h"
#import "UITableViewCell+Custom.h"
#import "foundationex/UIScreenEx.h"

@interface MineTableCell()
@property(nonatomic,weak) id<MineTableCellDelegate> delegate;
@end

@implementation MineTableCell

-(nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nonnull NSString *)reuseIdentifier indexPath:(nonnull NSIndexPath*) indexPath
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.textLabel.font = [UIFont boldSystemFontOfSize:FontScreenSize];
        self.textLabel.textColor = QQGLOBAL_COLOR(kTableViewCellTextLabelTextColorNormal);
        self.textLabel.highlightedTextColor = QQGLOBAL_COLOR(kTableViewCellTextLabelTextColorHighlighted);
        
        self.userInteractionEnabled = YES;
        

    }
    return self;
}

-(void) configureData:(NSString*) tipText
{
    [self setCustomAccessoryViewEnabled:YES];
    self.textLabel.text = tipText;
}

-(void) configureDataWithUISwtich:(BOOL) isOn tipText:(NSString*) tipText delegate:(id<MineTableCellDelegate>) delegate
{
    self.delegate = delegate;
    
    UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:mySwitch];
    self.accessoryView = mySwitch;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [mySwitch setOn:isOn];
    [mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    self.textLabel.text = tipText;
}


-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    
    if([self.delegate respondsToSelector:@selector(switchAction:)]){
        [self.delegate switchAction:isButtonOn];
    }
}

@end
