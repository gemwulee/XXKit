//
//  OSMOMenuController.m
//  XXKit
//
//  Created by tomxiang on 3/31/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOMenuController.h"
#import "UITableView+Global.h"
#import "UITableView+DJIUIKit.h"
#import "XXBase.h"
#import "OSMODataLoader.h"
#import "OSMOTableObject.h"
#import "Masonry.h"
#import "UITableViewCell+Custom.h"
#import "OSMOMenuNormaLCell.h"
#import "DJIIPhoneCameraModel.h"

@interface OSMOMenuController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView     *tableViewMenu;
@property(nonatomic,strong) NSMutableArray  *dataArray;
@property(nonatomic,copy)   NSString        *plistKey;

@property(nonatomic,weak)   OSMOEventAction *cameraAction;
@property(nonatomic,weak)   DJIIPhoneCameraModel *cameraModel;

@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@end

@implementation OSMOMenuController

-(BOOL) isNeedMutexPlist
{
    NSArray *metexArray = @[@"WhiteBalanceMenu",@"gridMenu"];
    if ([metexArray containsObject:self.plistKey]) {
        return YES;
    }
    return NO;
}

-(instancetype)initWithPlistKey:(NSString*) plistkey withModel:(DJIIPhoneCameraModel*) model camera:(OSMOEventAction*) cameraAction;
{
    if (self = [super init]) {
        self.plistKey = [plistkey copy];
        self.dataArray = [[OSMODataLoader sharedInstance] loadOSMOTableObjectsFromPlist:plistkey];
        self.cameraAction = cameraAction;
        self.cameraModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.layer.cornerRadius = 7;
    self.view.layer.masksToBounds = YES;
    self.view.layer.borderWidth = 1;
    self.view.layer.borderColor = [UIColor colorWithR:189 G:189 B:189 A:1].CGColor;
    
    [self setTextTitle : LOCALIZE(self.plistKey)];
    
    _tableViewMenu = [UITableView commonMenuStyledTableView:self dataSource:self frame:self.mainView.bounds];
    [self registerTableIdentifier];
    [self.mainView addSubview:_tableViewMenu];
    
    [_tableViewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainView);
    }];
}

-(void)registerTableIdentifier{
    [self.tableViewMenu  registerClass:[OSMOMenuNormaLCell class] forCellReuseIdentifier:OSMOMenuNormaLCellBaseIdentifier];

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
    
    if(settingObject && [settingObject.celldentifier isEqualToString:OSMOMenuNormaLCellBaseIdentifier]){

        OSMOMenuNormaLCell *cell = [tableView dequeueReusableCellWithIdentifier:OSMOMenuNormaLCellBaseIdentifier forIndexPath:indexPath];
        [cell updateMenuBackgroundViewInTableView:tableView atIndexPath:indexPath];
        [cell configureData:settingObject];
        
        [self _setUIMetexSelected:cell indexPath:indexPath];
        [self _setUISwitchState:settingObject.titleL cell:cell];
        [self _dealNormalSwitchEvent:settingObject.titleL cell:cell indexPath:indexPath];
        
        return cell;
    }
    
    return nil;
}

//处理需要互斥的逻辑tableview
-(void) _setUIMetexSelected:(OSMOMenuNormaLCell*) cell indexPath:(NSIndexPath*) indexPath
{
    if([self isNeedMutexPlist]){
        if (self.selectedIndexPath == indexPath) {
            [cell setCellSelected:YES];
        }else{
            [cell setCellSelected:NO];
        }
    }
}

-(void) _setUISwitchState:(NSString*) title cell:(OSMOMenuNormaLCell*) cell
{
    if (title && [title isEqualToString:@"mc_enterTravelMode_manual"]) {
        if(self.cameraModel.autoManual == DJIIPhone_SettingAuto){
            [cell setSwitchOn:NO];
        }else{
            [cell setSwitchOn:YES];
        }
    }
}

-(void) _dealNormalSwitchEvent:(NSString*) title cell:(OSMOMenuNormaLCell*) cell indexPath:(NSIndexPath*) indexPath{
    weakSelf(target);
    cell.clickSwitchButtonCell = ^(OSMOMenuNormaLCell *cell,BOOL isOn){
        weakReturn(target);
        if (title && [title isEqualToString:@"mc_enterTravelMode_manual"]) {
            if (isOn)
                self.cameraModel.autoManual = DJIIPhone_SettingManual;
            else
                self.cameraModel.autoManual = DJIIPhone_SettingAuto;
        }
    };
}

#pragma mark- Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OSMOTableObject *settingObject = [self.dataArray objectAtIndex:indexPath.row];
    
    if(!settingObject)
        return;
    
    NSString* childPlistKey = settingObject.childTablePlistKey;
    if(settingObject && childPlistKey.length > 0){
        OSMOMenuController *vctest = [[OSMOMenuController alloc] initWithPlistKey:childPlistKey withModel:self.cameraModel camera:self.cameraAction];
        [vctest setTextTitle:LOCALIZE(childPlistKey)];
        [self.navigationController pushViewController:vctest animated:YES];
    }else{
        self.selectedIndexPath = indexPath;
        [self.tableViewMenu reloadData];
        
        [self _dealNormalClickEvent:settingObject indexPath:indexPath];
    }
}

-(void) _dealNormalClickEvent:(OSMOTableObject *)settingObject indexPath:(NSIndexPath*) indexPath{
    


}


@end
