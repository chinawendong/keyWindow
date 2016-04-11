//
//  PhotoCollectionViewLayout.m
//  PhotoControllerView
//
//  Created by 云族佳 on 16/4/11.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import "PhotoCollectionViewLayout.h"

@implementation PhotoCollectionViewLayout{
    NSMutableArray *arrayItems;
    NSMutableArray *arraySize;
}

- (void)prepareLayout {
    [super prepareLayout];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    arrayItems = [NSMutableArray array];
    arraySize = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *item = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        [arrayItems addObject:item];
        
        if (_photoDelegate) {
            [arraySize addObject:[NSValue valueWithCGSize:[_photoDelegate photoCollectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath]]];
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *arr = [NSMutableArray array];
    CGFloat W = 0;
    for (int i = 0; i < arrayItems.count; i++) {
        UICollectionViewLayoutAttributes *item =  arrayItems[i];
        CGSize size = [arraySize[i] CGSizeValue];
        item.frame = CGRectMake(W, 0, 156 * size.width / size.height, 156);
        item.zIndex = item.indexPath.item + 1;
        [arr addObject:item];
        W += 156 * size.width / size.height + 10;
    }
    return arr;
}

- (CGSize)collectionViewContentSize {
    CGFloat W;
    for (NSValue *value in arraySize) {
        W += 156 * [value CGSizeValue].width / [value CGSizeValue].height + 10;
    }
    return CGSizeMake(W - 10,0);
}

@end
