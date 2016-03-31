//
//  OSMOMenuCell.m
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOMenuCell.h"
#import "XXBase.h"

@interface OSMOMenuCell()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *labelR;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewR;
@property (weak, nonatomic) IBOutlet UISwitch *swtichR;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewIndicator;
@end

@implementation OSMOMenuCell

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
        self.clickSwitchButtonCell(_swtichR);
    }
}

-(void) configureData:(NSString*) tipText image:(NSString*) imageStr indicator:(BOOL) isIndicator
{
    self.imageViewR.hidden = NO;
    self.swtichR.hidden = YES;
    self.labelR.hidden = YES;
    self.imageViewIndicator.hidden = !isIndicator;

    self.titleL.text = tipText;
    if(imageStr.length > 0){
        self.imageViewR.image = [UIImage imageNamed:imageStr];
    }
    
}

-(void) configureDatatipText:(NSString*) tipText swtich:(BOOL) isOn indicator:(BOOL) isIndicator
{
    self.imageViewR.hidden = YES;
    self.swtichR.hidden = NO;
    self.labelR.hidden = YES;
    self.imageViewIndicator.hidden = !isIndicator;
    
    self.titleL.text = tipText;
    self.swtichR.hidden = NO;
    [self.swtichR setOn:isOn];
  
}

-(void) configureDatatipText:(NSString*) tipText indicator:(BOOL) isIndicator
{
    self.imageViewR.hidden = YES;
    self.swtichR.hidden = YES;
    self.labelR.hidden = YES;
    self.imageViewIndicator.hidden = !isIndicator;
    
    self.titleL.text = tipText;
}

@end
