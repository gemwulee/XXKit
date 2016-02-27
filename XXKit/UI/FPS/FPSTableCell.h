//
//  FPSTableCell.h
//  XXKit
//
//  Created by tomxiang on 16/2/27.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XXTableCellHeight (100.f)
#define XXCELLIDENDIFIFY @"XX_CELL_IDENDIFIFY"

@interface FPSTableCell : UITableViewCell

- (void)configureForData:(NSInteger) row;

@end
