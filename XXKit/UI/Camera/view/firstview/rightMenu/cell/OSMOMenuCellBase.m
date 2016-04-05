//
//  OSMOMenuCell.m
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOMenuCellBase.h"
#import "XXBase.h"
#import "OSMOTableObject.h"

@interface OSMOMenuCellBase()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *labelR;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewR;
@property (weak, nonatomic) IBOutlet UISwitch *swtichR;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewIndicator;
@end

@implementation OSMOMenuCellBase

- (void)awakeFromNib {
    self.swtichR.hidden = YES;
    self.labelR.hidden = YES;
    self.imageViewR.hidden = YES;
    self.swtichR.hidden = YES;
    self.imageViewIndicator.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onSwitchValueChange:(UISwitch *)sender {
    weakSelf(target);
    if (self.clickSwitchButtonCell) {
        weakReturn(target);
        self.clickSwitchButtonCell(self,sender.isOn);
    }
}

-(void) configureData:(OSMOTableObject*) settingObject
{
    self.titleL.text = settingObject.titleL;
    
    if(settingObject.labelR.length > 0){
        self.labelR.text = settingObject.labelR;
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


@end
