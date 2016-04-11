//
//  FunctionView.m
//  keyWindow
//
//  Created by 云族佳 on 16/4/7.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import "FunctionView.h"

#import "PhotoCollectionViewLayout.h"

#import "PhotoCell.h"

#import "PhotoAlbumManager.h"

#import "PhtotViewController.h"

#import "PhotoAlbumControllerView.h"

@interface FunctionView ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PhotoCollectionViewLayoutDelegate>

@property (nonatomic, strong)UICollectionView *photoCollectionView;
@property (nonatomic, weak) ALAssetsGroup *group;

@property (nonatomic, strong) UIToolbar *photoToobar;

@end

@implementation FunctionView{
    NSMutableArray *images;
    UIBarButtonItem *barItem;
}

+ (FunctionView *)defaultFunctionView {
    static FunctionView *function;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        function = [[FunctionView alloc]init];
        function.backgroundColor = [UIColor groupTableViewBackgroundColor];
    });
    return function;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self addSubview:self.photoButton];
//        [self addSubview:self.cameraButton];
        [self addSubview:self.photoCollectionView];
        [self addSubview:self.photoToobar];
        NSArray *a = [PhotoAlbumManager defaultPhotoAlbumManager].photoGroups;
        [[PhotoAlbumManager defaultPhotoAlbumManager] setReloadDatas:^{
            self.group = [PhotoAlbumManager defaultPhotoAlbumManager].photoGroups.firstObject;
        }];
    }
    return self;
}

- (void)setGroup:(ALAssetsGroup *)group {
    _group = group;
    images = [NSMutableArray array];
    [[PhotoAlbumManager defaultPhotoAlbumManager].photoGroups.firstObject enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [images addObject:result];
        }else {
            [_photoCollectionView reloadData];
        }
    }];
}


- (void)didMoveToSuperview {
    [self loadFunctionButton];
}

- (void)loadFunctionButton {
    NSMutableArray *temp = [NSMutableArray array];
//    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_photoButton(55)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_photoButton)]];
//    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_photoButton(55)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_photoButton)]];
//    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_photoButton]-10-[_cameraButton(55)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_photoButton,_cameraButton)]];
//    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_cameraButton(55)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cameraButton)]];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_photoCollectionView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_photoCollectionView)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_photoCollectionView(150)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_photoCollectionView)]];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_photoToobar]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_photoToobar)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_photoToobar(44)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_photoToobar)]];
    [self addConstraints:temp];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    // Configure the cell
    ALAsset *asset = images[indexPath.row];
    cell.imageV.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
    
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
        barItem.title = [NSString stringWithFormat:@"发送(%@)", @([PhotoAlbumManager defaultPhotoAlbumManager].selectDictionary.allKeys.count)];

    }];
    return cell;
}

- (CGSize)photoCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ALAsset *ass = images[indexPath.row];
    ALAssetRepresentation *r = [ass defaultRepresentation];    
    return [r dimensions];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

- (void)pushPhotoAlbum {
    UIResponder *respoder = self.nextResponder;
    BOOL flag = YES;
    do {
        if ([respoder isKindOfClass:[UIViewController class]]) {
            flag = NO;
        }else {
            respoder = respoder.nextResponder;
        }
    } while (flag);
    UIViewController *viewC = (UIViewController *)respoder;
    PhtotViewController *vc = [[PhtotViewController alloc]init];

    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    NSMutableArray *a = nav.viewControllers.mutableCopy;
    PhotoAlbumControllerView *photoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoAlbumControllerView"];
    [a addObject:photoVC];
    [nav setViewControllers:a];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [viewC presentViewController:nav animated:YES completion:nil];
}

- (UIToolbar *)photoToobar {
    if (!_photoToobar) {
        _photoToobar = [[UIToolbar alloc]init];
        _photoToobar.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIBarButtonItem *xiangce = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(pushPhotoAlbum)];
        UIBarButtonItem *xiangji = [[UIBarButtonItem alloc]initWithTitle:@"相机" style:UIBarButtonItemStylePlain target:nil action:nil];
        barItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:nil action:nil];
        UIBarButtonItem *b = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        [_photoToobar setItems:@[xiangce,b,xiangji,b,b,b,b,b,b,b,barItem]];
        
    }
    return _photoToobar;
}

- (UICollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        PhotoCollectionViewLayout *flowLayout=[[PhotoCollectionViewLayout alloc] init];
        flowLayout.photoDelegate = self;
        _photoCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        _photoCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _photoCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_photoCollectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
    return _photoCollectionView;
}

@end
