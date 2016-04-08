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
#import "Masonry.h"

#define interitemSpacing 5.f

@interface OSMOVerticalPickerView()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray  *dataArray;
@property (nonatomic, strong) CAGradientLayer *maskLayer;
@end

@implementation OSMOVerticalPickerView

-(void) setDataSourceArray:(NSMutableArray*) array{
    self.dataArray = [array mutableCopy];
    [self.collectionView reloadData];
}

- (void)initData{
    self.dataArray = [NSMutableArray array];
}

- (void)initViews
{
    [self.collectionView removeFromSuperview];
    self.backgroundColor = [UIColor clearColor];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[OSMOVerticalPickerViewLayout new]];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[OSMOVerticalPickerViewCell class]
            forCellWithReuseIdentifier:NSStringFromClass([OSMOVerticalPickerViewCell class])];
    [self addSubview:self.collectionView];

    [self reloadSkins];
}

- (void)initEvent{}
- (void)refreshViewForIPhoneCameraMode{
    [_collectionView reloadData];
}
- (void)restoreDefaultStatus{}

#pragma mark- 横竖屏
-(void) layoutLandscape{
    _collectionView.frame = CGRectMake(0, 0, self.width/3, self.height);
}

-(void) layoutPortrait{
    _collectionView.frame = CGRectMake(0, 0, self.width/3, self.height);

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
    NSNumber *settingObject = [self.dataArray objectAtIndex:indexPath.row];
    
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
    CGSize size = CGSizeMake(collectionView.width, OSMOVerticalPickerViewItemHeight);
    return  size;
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
