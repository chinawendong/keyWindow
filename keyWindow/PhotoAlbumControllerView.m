//
//  PhotoAlbumControllerView.m
//  PhotoControllerView
//
//  Created by 云族佳 on 16/4/8.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import "PhotoAlbumControllerView.h"

#import "PhotoCell.h"

#import "PhotoToobar.h"

@interface PhotoAlbumControllerView ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSMutableArray *images;
}

@end

@implementation PhotoAlbumControllerView{
    __block PhotoToobar *toobar;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    toobar = [[PhotoToobar alloc]init];
    [self.view addSubview:toobar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dissmiss)];
}

- (void)dissmiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_group) {
        self.group = [PhotoAlbumManager defaultPhotoAlbumManager].photoGroups.firstObject;
    }
}

- (void)setGroup:(ALAssetsGroup *)group {
    _group = group;
    self.title = [group valueForProperty:ALAssetsGroupPropertyName];
    images = [NSMutableArray array];
    [_group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [images addObject:result];
        }else {
            NSLog(@"count : %@", @(images.count));
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    // Configure the cell
    ALAsset *asset = images[indexPath.row];
    cell.imageV.image = [UIImage imageWithCGImage:[asset thumbnail]];
    
    if ([PhotoAlbumManager defaultPhotoAlbumManager].selectDictionary[[NSString stringWithFormat:@"%@", @(indexPath.row)]]) {
        cell.types = IconTypeSelect;
    }else {
        cell.types = IconTypeSelectNome;
    }
    
    [cell setSelect:^(IconType flag) {
        switch (flag) {
            case IconTypeSelectNome:
                [[PhotoAlbumManager defaultPhotoAlbumManager].selectDictionary removeObjectForKey:[NSString stringWithFormat:@"%@", @(indexPath.row)]];
                break;
            case IconTypeSelect:
                [[PhotoAlbumManager defaultPhotoAlbumManager].selectDictionary setValue:@" " forKey:[NSString stringWithFormat:@"%@", @(indexPath.row)]];
                break;
            default:
                break;
        }
        toobar.buttonLabel.text = [NSString stringWithFormat:@"%@", @([PhotoAlbumManager defaultPhotoAlbumManager].selectDictionary.allKeys.count)];
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat W = (CGRectGetWidth(self.view.bounds) - 30) / 4;
    CGFloat H = W;
    return CGSizeMake(W, H);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[PhotoAlbumManager defaultPhotoAlbumManager].selectDictionary removeAllObjects];
}

@end
