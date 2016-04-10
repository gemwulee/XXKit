//
//  OSMOMenuNormaLCell.h
//  XXKit
//
//  Created by tomxiang on 4/7/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OSMOTableObject;

static NSString *const OSMOMenuNormaLCellBaseIdentifier = @"OSMOMenuNormaLCellBaseIdentifier";

@interface OSMOMenuNormaLCell : UITableViewCell

/**三种样式
 * 文字  图片  >
 * 文字  switch >
 * 文字  文字 >
 */

-(void) configureData:(OSMOTableObject*) settingObject;


@property (nonatomic, copy) void (^clickSwitchButtonCell)(OSMOMenuNormaLCell *cell,BOOL isOn);

-(void) setSwitchOn:(BOOL) isOn;

-(void) setCellSelected:(BOOL)selected;
@end
