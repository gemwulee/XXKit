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

@interface OSMOMenuController ()<UITableViewDelegate,UITableViewDataSource>

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
    self.title = self.plistKey ;
    
    _tableViewMenu = [UITableView commonMenuStyledTableView:self dataSource:self frame:self.mainView.bounds];
    [self registerTableIdentifier];
    [self.mainView addSubview:_tableViewMenu];
    
    [_tableViewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainView);
        make.width.equalTo(self.mainView);
        make.height.equalTo(self.mainView);
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OSMOViewBaseController *vctest = [[OSMOViewBaseController alloc] init];
    vctest.view.backgroundColor = [UIColor blackColor];
    vctest.title = @"test";
    [self.navigationController pushViewController:vctest animated:YES];
}


@end
