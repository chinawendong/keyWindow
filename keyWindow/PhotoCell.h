//
//  PhotoCell.h
//  PhotoControllerView
//
//  Created by 云族佳 on 16/4/8.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    IconTypeSelect,
    IconTypeSelectNome,
} IconType;

@interface PhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (nonatomic) IconType types;
@property (nonatomic, copy) void (^select)(IconType);

@end
