//
//  OSMOMenuController.m
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOMenuController.h"
#import "UITableView+Global.h"
#import "OSMOMenuCell.h"
#import "UITableView+DJIUIKit.h"
#import "XXBase.h"
#import "OSMOTableDataSource.h"

#define osmoBasicSettingHeaderHeight 46
#define osmoBasicSettingCellHeight 44
#define osmoBasicSettingFootHeight 10

@interface OSMOMenuController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIView          *viewHeader;
@property(nonatomic,strong) UITableView     *tableViewMenu;
@property(nonatomic,strong) NSMutableArray  *dataArray;

@end

@implementation OSMOMenuController

-(instancetype)init
{
    if (self = [super init]) {
        self.dataArray = [OSMOTableDataSource getOSMOCameraDataSource];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewHeader = [[UIView alloc] initWithFrame:self.view.bounds];
    NSString *cameraTitle = [OSMOTableDataSource getOSMOCameraTitle];
    self.title = cameraTitle;
    
    _tableViewMenu = [UITableView commonPlainStyledTableView:self dataSource:self frame:self.view.bounds];
    [self.view addSubview:_tableViewMenu];
    
    [self registerTableIdentifier];
}

-(void)registerTableIdentifier{
    [self.tableViewMenu registerNib:[UINib nibWithNibName:@"OSMOMenuCell" bundle:nil] forCellReuseIdentifier:OSMOMenuCellIdentifier];
}

#pragma mark- DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSMOMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:OSMOMenuCellIdentifier forIndexPath:indexPath];

    NSDictionary *dicCellRow = [self.dataArray objectAtIndex:indexPath.row];
    
    
    
    
    return cell;
}

#pragma mark- Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [UITableView roundedHandleTableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath withSectionColor:[UIColor clearColor] selectedColor:[UIColor colorWithR:255 G:255 B:255 A:0.2]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return osmoBasicSettingHeaderHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return osmoBasicSettingHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return osmoBasicSettingFootHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
