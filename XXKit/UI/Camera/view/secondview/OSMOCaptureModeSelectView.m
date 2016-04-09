//
//  OSMOCaptureModeSelectController.m
//  XXKit
//
//  Created by tomxiang on 4/5/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOCaptureModeSelectView.h"
#import "OSMOCaptureModeSelectCell.h"
#import "XXBase.h"
#import "OSMOToolViewController.h"
#import "OSMODataLoader.h"
#import "OSMOStateButton.h"
#import "OSMOCaptureModeSelectObject.h"

@interface OSMOCaptureModeSelectView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_mainCollectionView;
    UICollectionViewFlowLayout *_layout;
}
@property(nonatomic,copy)   NSString        *plistKey;
@property(nonatomic,strong) NSMutableArray  *dataArray;


@end

@implementation OSMOCaptureModeSelectView

- (instancetype)initWithFrame:(CGRect)frame withModel:(DJIIPhoneCameraModel*) model camera:(OSMOEventAction*) cameraAction plist:(NSString*) plistkey
{
    if (self = [super initWithFrame:frame withModel:model camera:cameraAction]) {
        self.plistKey = [plistkey copy];
        self.dataArray = [[OSMODataLoader sharedInstance] loadOSMOCaptureModeObjectsFromPlist:plistkey];
    }
    return self;
}
- (void)initData{}
- (void)initViews
{
    // Do any additional setup after loading the view.
    self.backgroundColor = [UIColor clearColor];
    //1.初始化layout
    _layout = [[UICollectionViewFlowLayout alloc] init];
    
    //2.初始化collectionView
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout];
    _mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [self registerReuseIdentifier];
    
    //4.设置代理
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    
    [self addSubview:_mainCollectionView];

    [self reloadSkins];
}
- (void)initEvent{}
- (void)registerReuseIdentifier{
    [_mainCollectionView registerClass:[OSMOCaptureModeSelectCell class] forCellWithReuseIdentifier:OSMOPhotoSingleModeIdentifier];
    [_mainCollectionView registerClass:[OSMOCaptureModeSelectCell class] forCellWithReuseIdentifier:OSMOPhotoPanoModeIdentifier];

}
#pragma mark- 横竖屏
-(void) layoutLandscape{
    _mainCollectionView.frame = CGRectMake(0, 0, paramSettingWidth, self.height);
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
}

-(void) layoutPortrait{
    _mainCollectionView.frame = CGRectMake(0, 0, self.width, self.height);
    [_layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
}

-(void) refreshViewForIPhoneCameraMode{
    [_mainCollectionView reloadData];
}

- (void)restoreDefaultStatus{}


#pragma mark- Collectionview
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OSMOCaptureModeSelectObject *settingObject = [self.dataArray objectAtIndex:indexPath.row];
    
    if(!settingObject)
        return nil;
    
    if(settingObject && [settingObject.celldentifier isEqualToString:OSMOPhotoSingleModeIdentifier]){
        OSMOCaptureModeSelectCell *cell = (OSMOCaptureModeSelectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:OSMOPhotoSingleModeIdentifier forIndexPath:indexPath];
        [cell configureData:settingObject];
        [self _setUIPhotoSingleButtonState:settingObject.buttonTextN selectCell:cell];
        [self _setPhotoClickAction:cell indexPath:indexPath];
        return cell;
    }
    else if(settingObject && [settingObject.celldentifier isEqualToString:OSMOPhotoPanoModeIdentifier]){
        OSMOCaptureModeSelectCell *cell = (OSMOCaptureModeSelectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:OSMOPhotoPanoModeIdentifier forIndexPath:indexPath];
        [cell configureData:settingObject];
        
        [self _setUIPhotoPanoButtonState:settingObject.buttonTextN selectCell:cell];
        [self _setPanoClickAction:cell indexPath:indexPath];
        
        return cell;
    }
    return nil;
}



//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(paramSettingWidth-10, paramSettingWidth-10);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark- private method
-(void) _setUIPhotoSingleButtonState:(NSString*) buttonN selectCell:(OSMOCaptureModeSelectCell*) cell
{
    switch (self.cameraModel.photoSingleModeDetail)
    {
        case DJIIPhone_PhotoSingleModeDetail_Single_Normal:{
            if([buttonN isEqualToString:@"0"]){
                [cell setButtonSelected:YES];
            }else{
                [cell setButtonSelected:NO];
            }
        }
            break;
        case DJIIPhone_PhotoSingleModeDetail_Single_Delay_2:{
            if([buttonN isEqualToString:@"2"]){
                [cell setButtonSelected:YES];
            }else{
                [cell setButtonSelected:NO];
            }
        }
            break;
        case DJIIPhone_PhotoSingleModeDetail_Single_Delay_5:{
            if([buttonN isEqualToString:@"5"]){
                [cell setButtonSelected:YES];
            }else{
                [cell setButtonSelected:NO];
            }
        }
            break;
        case DJIIPhone_PhotoSingleModeDetail_Single_Delay_10:{
            if([buttonN isEqualToString:@"10"]){
                [cell setButtonSelected:YES];
            }else{
                [cell setButtonSelected:NO];
            }
        }
            break;
    }
}

-(void) _setPhotoClickAction:(OSMOCaptureModeSelectCell *) cell indexPath:(NSIndexPath*) indexPath{
    weakSelf(target);
    cell.clickButtonAction = ^(OSMOCaptureModeSelectCell *cell,id sender){
        weakReturn(target);
        //外部会观察到内部的变化从而去刷新
        OSMOCaptureModeSelectObject *settingObject = [target.dataArray objectAtIndex:indexPath.row];
        if([settingObject.buttonTextN isEqualToString:@"0"]){
            [target.cameraAction actionClick_PhotoSingleNormalMode_OSMOCaptureModeSelectView:sender];
        }else if ([settingObject.buttonTextN isEqualToString:@"2"]){
            [target.cameraAction actionClick_PhotoSingleDelay2Mode_OSMOCaptureModeSelectView:sender];
            
        }else if ([settingObject.buttonTextN isEqualToString:@"5"]){
            [target.cameraAction actionClick_PhotoSingleDelay5Mode_OSMOCaptureModeSelectView:sender];
        }else if ([settingObject.buttonTextN isEqualToString:@"10"]){
            [target.cameraAction actionClick_PhotoSingleDelay10Mode_OSMOCaptureModeSelectView:sender];
            
        }
    };
}

-(void) _setUIPhotoPanoButtonState:(NSString*) buttonN selectCell:(OSMOCaptureModeSelectCell*) cell
{
    switch (self.cameraModel.photoPanoModeDetail)
    {
        case DJIIPhone_PhotoPanoModeDetail_180:{
            if([buttonN isEqualToString:@"180"]){
                [cell setButtonSelected:YES];
            }else{
                [cell setButtonSelected:NO];
            }
        }
            break;
        case DJIIPhone_PhotoPanoModeDetail_360:{
            if([buttonN isEqualToString:@"360"]){
                [cell setButtonSelected:YES];
            }else{
                [cell setButtonSelected:NO];
            }
        }
            break;
        case DJIIPhone_PhotoPanoModeDetail_720:{
            if([buttonN isEqualToString:@"720"]){
                [cell setButtonSelected:YES];
            }else{
                [cell setButtonSelected:NO];
            }
        }
            break;
    }
}

-(void) _setPanoClickAction:(OSMOCaptureModeSelectCell *) cell indexPath:(NSIndexPath*) indexPath{
    weakSelf(target);
    cell.clickButtonAction = ^(OSMOCaptureModeSelectCell *cell,id sender){
        weakReturn(target);
        //外部会观察到内部的变化从而去刷新
        OSMOCaptureModeSelectObject *settingObject = [target.dataArray objectAtIndex:indexPath.row];
        if([settingObject.buttonTextN isEqualToString:@"180"]){
            [target.cameraAction actionClick_PhotoPano180Mode_OSMOCaptureModeSelectView:sender];
        }else if ([settingObject.buttonTextN isEqualToString:@"360"]){
            [target.cameraAction actionClick_PhotoPano360Mode_OSMOCaptureModeSelectView:sender];
            
        }else if ([settingObject.buttonTextN isEqualToString:@"720"]){
            [target.cameraAction actionClick_PhotoPano720Mode_OSMOCaptureModeSelectView:sender];
        }
    };
}


@end
