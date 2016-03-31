//
//  OSMOMenuCell.h
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString *const OSMOMenuCellIdentifier = @"OSMOMenuCellIdentifier";


@interface OSMOMenuCell : UITableViewCell


/**
  * 文字  图片  >
 */
-(void) configureData:(NSString*) tipText image:(NSString*) imageStr indicator:(BOOL) isIndicator;

/**
  * 文字  switch
  */
-(void) configureDatatipText:(NSString*) tipText swtich:(BOOL) isOn indicator:(BOOL) isIndicator;

/**
 * 文字
 */
-(void) configureDatatipText:(NSString*) tipText indicator:(BOOL) isIndicator;


@property (nonatomic, copy) void (^clickSwitchButtonCell)(UISwitch *switchButton);


@end
