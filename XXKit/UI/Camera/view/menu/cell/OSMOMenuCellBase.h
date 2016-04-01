//
//  OSMOMenuCell.h
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OSMOTableObject;

static NSString *const OSMOMenuCellBaseIdentifier = @"OSMOMenuCellBaseIdentifier";


@interface OSMOMenuCellBase : UITableViewCell

/**三种样式
 * 文字  图片  >
 * 文字  switch >
 * 文字  文字 >
 */

-(void) configureData:(OSMOTableObject*) settingObject;


@property (nonatomic, copy) void (^clickSwitchButtonCell)(UISwitch *switchButton);


@end
