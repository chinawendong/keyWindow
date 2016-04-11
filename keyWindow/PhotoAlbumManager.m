//
//  PhotoAlbumManager.m
//  PhotoControllerView
//
//  Created by 云族佳 on 16/4/8.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import "PhotoAlbumManager.h"

@implementation PhotoAlbumManager

+ (PhotoAlbumManager *)defaultPhotoAlbumManager {
    static PhotoAlbumManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PhotoAlbumManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSMutableArray *)photoGroups {
    if (!_photoGroups) {
        _photoGroups = [NSMutableArray array];
        [self enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group) {
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"相机胶卷"]) {
                    [_photoGroups insertObject:group atIndex:0];
                }else {
                    [_photoGroups  addObject:group];
                }
            }else {
                if (_reloadDatas) {
                    _reloadDatas();
                }
            }
        } failureBlock:^(NSError *error) {
            NSAssert(error, [error localizedFailureReason]);
        }];
    }
    return _photoGroups;
}

- (NSMutableDictionary *)selectDictionary {
    if (!_selectDictionary) {
        _selectDictionary = [NSMutableDictionary dictionary];
    }
    return _selectDictionary;
}

@end
