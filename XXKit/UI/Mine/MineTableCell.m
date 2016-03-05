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
-(void) configureData:(NSString *)value
{
    [self setCustomAccessoryViewEnabled:YES];
    self.textLabel.text = value;
}

@end
