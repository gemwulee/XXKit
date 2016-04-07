//
//  OSMOVerticalPickerView.m
//  XXKit
//
//  Created by tomxiang on 4/7/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOVerticalPickerView.h"
#import "OSMOVerticalPickerViewLayout.h"
#import "OSMOVerticalPickerViewCell.h"
#import "XXBase.h"

#define interitemSpacing 5.f

@interface OSMOVerticalPickerView()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation OSMOVerticalPickerView

- (void)initViews
{
    [self.collectionView removeFromSuperview];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds
                                             collectionViewLayout:[OSMOVerticalPickerViewLayout new]];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.collectionView registerClass:[OSMOVerticalPickerViewCell class]
            forCellWithReuseIdentifier:NSStringFromClass([OSMOVerticalPickerViewCell class])];
    [self addSubview:self.collectionView];
    
    CAGradientLayer *maskLayer = [CAGradientLayer layer];
    maskLayer.frame = self.collectionView.bounds;
    maskLayer.colors = @[(id)[[UIColor clearColor] CGColor],
                         (id)[[UIColor blackColor] CGColor],
                         (id)[[UIColor blackColor] CGColor],
                         (id)[[UIColor clearColor] CGColor],];
    maskLayer.locations = @[@0.0, @0.33, @0.66, @1.0];
    maskLayer.startPoint = CGPointMake(0.0, 0.0);
    maskLayer.endPoint = CGPointMake(0.0, 1.0);
    self.collectionView.layer.mask = maskLayer;

    [self reloadSkins];
}

-(void)initData
{
    self.dataArray = [NSMutableArray array];
}

#pragma mark- 横竖屏
-(void) layoutLandscape{
    _collectionView.frame = CGRectMake(0, 0, self.width *1.F /3, self.height);
}

-(void) layoutPortrait{
    _collectionView.frame = CGRectMake(0, 0, self.width *1.F /3, self.height);
}

-(void) setNewStatus{
    [_collectionView reloadData];
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
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *settingObject = [self.dataArray objectAtIndex:indexPath.row];
    
    if(!settingObject)
        return nil;
    NSString *identifier = NSStringFromClass([OSMOVerticalPickerViewCell class]);
    OSMOVerticalPickerViewCell *item = (OSMOVerticalPickerViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [item configureData:settingObject];
    return item;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.width, OSMOVerticalPickerViewItemHeight) ;
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



@end
