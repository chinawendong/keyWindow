//
//  PhotoAlbumManager.h
//  PhotoControllerView
//
//  Created by 云族佳 on 16/4/8.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoAlbumManager : ALAssetsLibrary

@property (nonatomic, strong) NSMutableArray *photoGroups;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableDictionary *selectDictionary;

@property (nonatomic, copy) void (^reloadDatas)();

+ (PhotoAlbumManager *)defaultPhotoAlbumManager;

@end
