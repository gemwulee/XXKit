//
//  XXBaseViewController.h
//  XXKit
//
//  Created by tomxiang on 16/3/9.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXViewController.h"
@class XXBaseViewModel;

#define ITEM_CONTENT @"itemContent"
#define ITEM_KEY     @"itemKey"
#define ITEM_ACCOUNT @"itemAccount"
#define ITEM_VALUE @"itemValue"
#define ITEM_IMAGE @"itemImage"

@protocol XXBaseVCRequireMethod <NSObject>
@required
-(NSString*) getViewModelFileName;
@end

@interface XXBaseViewController : XXViewController<XXBaseVCRequireMethod>

@property(nonatomic,strong) UITableView *baseTableView;
@property(nonatomic,strong) XXBaseViewModel *baseViewModel;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
