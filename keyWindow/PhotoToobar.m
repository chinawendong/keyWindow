//
//  PhotoToobar.m
//  PhotoControllerView
//
//  Created by 云族佳 on 16/4/11.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import "PhotoToobar.h"

#import "PhotoAlbumManager.h"

@interface PhotoToobar ()

@property (nonatomic, strong) PhotoAlbumManager *manager;

@end

@implementation PhotoToobar
@synthesize buttonLabel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpSubviews];
        [self addKVO];
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self setUpConStraints];
}

- (void)addKVO {
    [buttonLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setUpSubviews {
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    buttonLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, 11, 22, 22)];
    buttonLabel.text = @"0";
    buttonLabel.hidden = YES;
    buttonLabel.font = [UIFont systemFontOfSize:13];
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    buttonLabel.layer.cornerRadius = 11;
    buttonLabel.layer.masksToBounds = YES;
    buttonLabel.backgroundColor = [UIColor colorWithRed:0.001 green:0.393 blue:0.004 alpha:1.000];
    buttonLabel.textColor = [UIColor whiteColor];
    UIButton *buttonSend = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonSend setTitle:@"发送" forState:UIControlStateNormal];
    [buttonSend setTitleColor:[UIColor colorWithRed:0.001 green:0.393 blue:0.004 alpha:1.000] forState:UIControlStateNormal];
    [buttonSend addTarget:self action:@selector(targetButton) forControlEvents:UIControlEventTouchUpInside];
    buttonSend.frame = CGRectMake(44, 0, 44, 44);
    [buttonView addSubview:buttonLabel];
    [buttonView addSubview:buttonSend];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"预览" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc]initWithCustomView:buttonView];
    UIBarButtonItem *b = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil ];
    [self setItems:@[bar,b,b,b,b,b,b,b,bar1]];
}

- (void)setUpConStraints {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    if (!self.superview) {
        return;
    }
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *rigth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *boom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *H = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44];
    [self.superview addConstraints:@[left,rigth,boom,H]];
}

- (void)targetButton {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([change[@"new"] integerValue] > 0) {
        buttonLabel.hidden = NO;
    }else {
        buttonLabel.hidden = YES;
    }
}

- (PhotoAlbumManager *)manager {
    if (!_manager) {
        _manager = [PhotoAlbumManager defaultPhotoAlbumManager];
    }
    return _manager;
}

-(void)dealloc {
    [buttonLabel removeObserver:self forKeyPath:@"text" context:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
