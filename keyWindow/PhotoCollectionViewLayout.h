//
//  PhotoCollectionViewLayout.h
//  PhotoControllerView
//
//  Created by 云族佳 on 16/4/11.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  PhotoCollectionViewLayoutDelegate <NSObject>
- (CGSize)photoCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface PhotoCollectionViewLayout : UICollectionViewLayout
@property (nonatomic, assign) id<PhotoCollectionViewLayoutDelegate>photoDelegate;

@end
