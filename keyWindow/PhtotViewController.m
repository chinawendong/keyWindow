//
//  ViewController.m
//  PhotoControllerView
//
//  Created by 云族佳 on 16/4/7.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import "PhtotViewController.h"
#import "PhotoAlbumManager.h"
#import "PhotoAlbumControllerView.h"

@interface PhtotViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *imagess;

@end

@implementation PhtotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [[PhotoAlbumManager defaultPhotoAlbumManager] setReloadDatas:^{
        [self.tableView reloadData];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dissmiss)];
}

- (void)dissmiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [PhotoAlbumManager defaultPhotoAlbumManager].photoGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ALAssetsGroup *group = [PhotoAlbumManager defaultPhotoAlbumManager].photoGroups[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)", [group valueForProperty:ALAssetsGroupPropertyName],@([group numberOfAssets])];
    cell.imageView.image = [UIImage imageWithCGImage:[group posterImage]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoAlbumControllerView *photoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoAlbumControllerView"];
    photoVC.group = [PhotoAlbumManager defaultPhotoAlbumManager].photoGroups[indexPath.row];
    [self.navigationController pushViewController:photoVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)loadView {
    [super loadView];
//    NSMutableArray *a = self.navigationController.viewControllers.mutableCopy;
//    PhotoAlbumControllerView *photoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoAlbumControllerView"];
//    [a addObject:photoVC];
//    [self.navigationController setViewControllers:a animated:YES];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
