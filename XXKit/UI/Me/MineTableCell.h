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


@protocol MineTableCellDelegate <NSObject>
-(void) switchAction : (BOOL) isOn;
@end

@interface MineTableCell : UITableViewCell

-(void) configureData:(NSString*) tipText;

-(void) configureDataWithUISwtich:(BOOL) isOn tipText:(NSString*) tipText delegate:(id<MineTableCellDelegate>) delegate;


@end
