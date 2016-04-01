//
//  OSMOMenuController.m
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOMenuController.h"
#import "UITableView+Global.h"
#import "OSMOMenuCellBase.h"
#import "UITableView+DJIUIKit.h"
#import "XXBase.h"
#import "OSMODataLoader.h"
#import "OSMOTableObject.h"
#import "Masonry.h"
#import "UITableViewCell+Custom.h"

#define osmoBasicSettingHeaderHeight 46
#define osmoBasicSettingCellHeight 44
#define osmoBasicSettingFootHeight 10

@interface OSMOMenuController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIView          *viewHeader;
@property(nonatomic,strong) UITableView     *tableViewMenu;
@property(nonatomic,strong) NSMutableArray  *dataArray;

@property(nonatomic,copy)   NSString        *plistKey;

@end

@implementation OSMOMenuController

-(instancetype)initWithPlistKey:(NSString*) plistkey
{
    if (self = [super init]) {
        self.plistKey = [plistkey copy];
        self.dataArray = [[OSMODataLoader sharedInstance] loadOSMOTableObjectsFromPlist:plistkey];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewHeader = [[UIView alloc] initWithFrame:self.view.bounds];
    self.title = self.plistKey ;
    
    _tableViewMenu = [UITableView commonMenuStyledTableView:self dataSource:self frame:self.view.bounds];
    [self registerTableIdentifier];
    [self.view addSubview:_tableViewMenu];
    
    [_tableViewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
}

-(void)registerTableIdentifier{
    [self.tableViewMenu registerNib:[UINib nibWithNibName:@"OSMOMenuCellBase" bundle:nil] forCellReuseIdentifier:OSMOMenuCellBaseIdentifier];
}

#pragma mark- DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSMOTableObject *settingObject = [self.dataArray objectAtIndex:indexPath.row];
    
    if(!settingObject)
        return nil;
    
    if(settingObject && [settingObject.celldentifier isEqualToString:OSMOMenuCellBaseIdentifier]){
        OSMOMenuCellBase *cell = [tableView dequeueReusableCellWithIdentifier:OSMOMenuCellBaseIdentifier forIndexPath:indexPath];        
        [cell updateMenuBackgroundViewInTableView:tableView atIndexPath:indexPath];
        [cell configureData:settingObject];
        return cell;
    }
    
    
    return nil;

}

#pragma mark- Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return osmoBasicSettingHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return osmoBasicSettingHeaderHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
