//
//  MineTableCell.h
//  XXKit
//
//  Created by tomxiang on 16/3/5.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MINETableCellHeight (100.f)
#define MINECELLIDENDIFIFY @"MINE_CELL_IDENDIFIFY"

@interface MineTableCell : UITableViewCell

-(void) configureData:(NSString*) value;

@end
