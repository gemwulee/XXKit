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

@interface OSMOCaptureModeSelectView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *mainCollectionView;
    UICollectionViewFlowLayout *_layout;
}

@end

@implementation OSMOCaptureModeSelectView

-(void)initViews
{
    // Do any additional setup after loading the view.
    self.backgroundColor = [UIColor whiteColor];
    
    //1.初始化layout
    _layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [_layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout];
    [self addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerClass:[OSMOCaptureModeSelectCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    
    [self reloadSkins];
}

#pragma mark- 横竖屏


-(void) layoutLandscape{
    mainCollectionView.frame = CGRectMake(0, 0, paramSettingWidth, self.height);
    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
}

-(void) layoutPortrait{
    mainCollectionView.frame = CGRectMake(0, 0, self.width, self.height);

    [_layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
}

-(void) setNewStatus{
    [mainCollectionView reloadData];
}

//设置顶部的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size={0,0};
    return size;
}

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
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OSMOCaptureModeSelectCell *cell = (OSMOCaptureModeSelectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(paramSettingWidth, paramSettingWidth);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}




@end
