//
//  HomeTableCell.h
//  XXKit
//
//  Created by tomxiang on 16/2/27.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XXTableCellHeight (60.f)

#define XXCELLIDENDIFIFY @"XX_CELL_IDENDIFIFY"

@class XXMessageModel;

@interface HomeTableCell : UITableViewCell

- (void)configureForData:(XXMessageModel*) xxMsgModel row:(NSInteger) msgRow;

@end
