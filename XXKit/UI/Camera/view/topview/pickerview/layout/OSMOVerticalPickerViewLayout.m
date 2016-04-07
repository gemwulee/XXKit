//
//  OSMOVerticalPickerViewLayout.m
//  XXKit
//
//  Created by tomxiang on 4/7/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOVerticalPickerViewLayout.h"
@interface OSMOVerticalPickerViewLayout()
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat midX;
@property (nonatomic, assign) CGFloat maxAngle;
@end

@implementation OSMOVerticalPickerViewLayout

- (id)init
{
    self = [super init];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 0.0;
    }
    return self;
}

- (void)prepareLayout
{
    CGRect visibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.bounds.size};
    self.midX = CGRectGetMidX(visibleRect);
    self.width = CGRectGetWidth(visibleRect) / 2;
    self.maxAngle = M_PI_2;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    CGFloat distance = CGRectGetMidX(attributes.frame) - self.midX;
    CGFloat currentAngle = self.maxAngle * distance / self.width / M_PI_2;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, -distance, 0, -self.width);
    transform = CATransform3DRotate(transform, currentAngle, 0, 1, 0);
    transform = CATransform3DTranslate(transform, 0, 0, self.width);
    attributes.transform3D = transform;
    
    attributes.alpha = (ABS(currentAngle) < self.maxAngle);
    
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [NSMutableArray array];
    if ([self.collectionView numberOfSections]) {
        for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    return attributes;
}


@end
