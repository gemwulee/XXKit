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
@end

@implementation OSMOMenuController

-(void) refreshViewForIPhoneCameraMode{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableViewMenu reloadData];
    });
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
        //处理互斥显示的UI逻辑
        [self _setUIMetexSelected:settingObject.titleL cell:cell];
        
        //处理uiswitch的显示和点击
        [self _setUISwitchState:settingObject.titleL cell:cell];
        [self _dealNormalSwitchEvent:settingObject cell:cell];
        
        return cell;
    }
    
    return nil;
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
        [self _dealNormalClickEvent:settingObject indexPath:indexPath];
    }
}


#pragma mark- private method
-(void) _dealNormalClickEvent:(OSMOTableObject *)settingObject indexPath:(NSIndexPath*) indexPath{
    if(self.plistKey && [self.plistKey isEqualToString:@"WhiteBalanceMenu"]){
        if ([settingObject.titleL isEqualToString:@"camera_setting_wb_value_auto_intro"]) {             //自动
            [self.cameraAction onActionClickWhiteBalanceMetux:settingObject status:DJIIPhone_WhiteBalanceAuto];
        }else if([settingObject.titleL isEqualToString:@"camera_setting_wb_value_indoor_intro"]) {      //阴天
            [self.cameraAction onActionClickWhiteBalanceMetux:settingObject status:DJIIPhone_WhiteBalanceIndoor];
        }else if([settingObject.titleL isEqualToString:@"camera_setting_wb_value_neon_intro"]) {        //荧光灯
            [self.cameraAction onActionClickWhiteBalanceMetux:settingObject status:DJIIPhone_WhiteBalanceNeon];
        }else if([settingObject.titleL isEqualToString:@"camera_setting_wb_value_outdoor_intro"]) {     //晴天
            [self.cameraAction onActionClickWhiteBalanceMetux:settingObject status:DJIIPhone_WhiteBalanceOutdoor];
        }else if([settingObject.titleL isEqualToString:@"camera_setting_wb_value_tungsten_intro"]) {    //白织灯
            [self.cameraAction onActionClickWhiteBalanceMetux:settingObject status:DJIIPhone_WhiteBalancetTungsten];
        }else if([settingObject.titleL isEqualToString:@"advanced_more_whitebalance_custom_intro"]) {   //自定义
            [self.cameraAction onActionClickWhiteBalanceMetux:settingObject status:DJIIPhone_WhiteBalanceCustom];
        }
    }else if(self.plistKey && [self.plistKey isEqualToString:@"gridMenu"]){
        if ([settingObject.titleL isEqualToString:@"handleGridNone"]) {
            [self.cameraAction onActionClickGridMetux:settingObject status:DJIIPhone_GridNoneStyle];
        }else if([settingObject.titleL isEqualToString:@"handleGridDiagonal"]) {
            [self.cameraAction onActionClickGridMetux:settingObject status:DJIIPhone_GridCircleDiagonalStyle];
        }else if([settingObject.titleL isEqualToString:@"handleGridSquare"]) {
            [self.cameraAction onActionClickGridMetux:settingObject status:DJIIPhone_GridSquareStyle];
        }else if([settingObject.titleL isEqualToString:@"handleGridCenter"]) {
            [self.cameraAction onActionClickGridMetux:settingObject status:DJIIPhone_GridCenterPointStyle];
        }
    }
}

//处理需要互斥的逻辑tableview
-(void) _setUIMetexSelected:(NSString*) buttonN cell:(OSMOMenuNormaLCell*) cell{
    if(self.plistKey && [self.plistKey isEqualToString:@"WhiteBalanceMenu"]){
        switch (self.cameraModel.balanceWhiteBalanceMode) {
            case  DJIIPhone_WhiteBalanceAuto:{
                [self _setCellSelected:buttonN compareString:@"camera_setting_wb_value_auto_intro" cell:cell];
            }
                break;
            case  DJIIPhone_WhiteBalanceIndoor:{     //阴天
                [self _setCellSelected:buttonN compareString:@"camera_setting_wb_value_indoor_intro" cell:cell];
            }
                break;
            case DJIIPhone_WhiteBalanceNeon:{      //荧光灯
                [self _setCellSelected:buttonN compareString:@"camera_setting_wb_value_neon_intro" cell:cell];
            }
                break;
            case DJIIPhone_WhiteBalanceOutdoor:{    //晴天
                [self _setCellSelected:buttonN compareString:@"camera_setting_wb_value_outdoor_intro" cell:cell];
            }
                break;
            case DJIIPhone_WhiteBalancetTungsten:{  //白织灯
                [self _setCellSelected:buttonN compareString:@"camera_setting_wb_value_tungsten_intro" cell:cell];
            }
                break;
            case  DJIIPhone_WhiteBalanceCustom:{    //自定义
                [self _setCellSelected:buttonN compareString:@"advanced_more_whitebalance_custom_intro" cell:cell];
            }
                break;
        }
    }else if(self.plistKey && [self.plistKey isEqualToString:@"gridMenu"]){
        switch (self.cameraModel.gridStyle) {
            case  DJIIPhone_GridNoneStyle:{ //无
                [self _setCellSelected:buttonN compareString:@"handleGridNone" cell:cell];
            }
                break;
            case  DJIIPhone_GridCircleDiagonalStyle:{//网格＋对角线
                [self _setCellSelected:buttonN compareString:@"handleGridDiagonal" cell:cell];
            }
                break;
            case DJIIPhone_GridSquareStyle:{                   //方格
                [self _setCellSelected:buttonN compareString:@"handleGridSquare" cell:cell];
            }
                break;
            case DJIIPhone_GridCenterPointStyle:{             //中心点
                [self _setCellSelected:buttonN compareString:@"handleGridCenter" cell:cell];
            }
                break;
        }
    }
}

-(void) _setCellSelected:(NSString*) buttonN compareString:(NSString*) compareString cell:(OSMOMenuNormaLCell*) cell{
    if ([buttonN isEqualToString:compareString]) {
        [cell setCellSelected:YES];
    }else{
        [cell setCellSelected:NO];
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

-(void) _dealNormalSwitchEvent:(OSMOTableObject *)settingObject  cell:(OSMOMenuNormaLCell*) cell{
    weakSelf(target);
    cell.clickSwitchButtonCell = ^(OSMOMenuNormaLCell *cell,BOOL isOn){
        weakReturn(target);
        [target.cameraAction onSwitchChanged:settingObject status:isOn];
    };
}


@end
