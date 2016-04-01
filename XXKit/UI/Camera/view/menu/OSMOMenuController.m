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
    
    _tableViewMenu = [UITableView commonPlainStyledTableView:self dataSource:self frame:self.view.bounds];
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
        cell.contentView.backgroundColor = [UIColor blackColor];
        [cell configureData:settingObject];
        return cell;
    }
    return nil;

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

#pragma marks - UITableView Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, osmoBasicSettingHeaderHeight)];
    [sectionHeaderView setBackgroundColor:[UIColor clearColor]];
    //下划线
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
    lineLayer.frame = CGRectMake(0, sectionHeaderView.frame.size.height-lineHeight, sectionHeaderView.frame.size.width, lineHeight);
    lineLayer.backgroundColor = tableView.separatorColor.CGColor;
    [sectionHeaderView.layer addSublayer:lineLayer];
    return sectionHeaderView;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,osmoBasicSettingHeaderHeight)];
    [sectionFooterView setBackgroundColor:[UIColor clearColor]];
    return sectionFooterView;
}


@end
