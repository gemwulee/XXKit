//
//  OSMOTableDataSource.h
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OSMO_MENU_TABLEVIEW_TITLE @"OSMO_MENU_TABLEVIEW_TITLE"
#define OSMO_MENU_CELL_LABEL_L  @"OSMO_MENU_CELL_LABEL_L"

#define OSMO_MENU_CELL_SWITCH_R @"OSMO_MENU_CELL_SWITCH_R"
#define OSMO_MENU_CELL_LABEL_R  @"OSMO_MENU_CELL_LABEL_R"
#define OSMO_MENU_CELL_IMAGE_R  @"OSMO_MENU_CELL_IMAGE_R"

#define OSMO_MENU_CELL_IMAGE_INDICATOR  @"OSMO_MENU_CELL_IMAGE_INDICATOR"


@interface OSMOTableObject : NSObject

@property (strong, nonatomic)  NSString *titleL;         //左侧的名字

@property (strong, nonatomic)  NSString *labelR;         //右侧的label名字
@property (strong, nonatomic)  NSString *imageViewR;     //label右侧的图片

@property (assign, nonatomic)  BOOL swtichR;             //是否有switch
@property (assign, nonatomic)  BOOL showRightSideImage;  //右边箭头图或加号图

- (instancetype) initWithDic:(NSDictionary*) dic;

@end
