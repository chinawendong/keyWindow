//
//  ExpressionView.m
//  keyWindow
//
//  Created by 云族佳 on 16/4/6.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import "ExpressionView.h"

#import "EmojiItemView.h"

#import "MHEmoji.h"

@interface ExpressionView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) EmojiItemView *emojiItemView;

@end

@implementation ExpressionView
@synthesize scrollView;

+ (ExpressionView *)defaultExpressionView {
    static ExpressionView *expressionView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        expressionView = [[ExpressionView alloc]init];
    });
    return expressionView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self laodEmojiItemView];
        [self loadEmoji:_emojiItemView.emojis.firstObject];
    }
    return self;
}

- (void)laodEmojiItemView {
    self.emojiItemView = [[EmojiItemView alloc]init];
    _emojiItemView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_emojiItemView];
    __weak typeof(self) weakSelf = self;
    __weak typeof(_emojiItemView) emoji = _emojiItemView;
    [_emojiItemView setSlectEmopjis:^(NSInteger idx) {
        [weakSelf loadEmoji:emoji.emojis[idx]];
    }];
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    
    self.pageControl = [[UIPageControl alloc]init];
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.227 alpha:1.000];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self addSubview:_pageControl];
    
    NSMutableArray *temp = [NSMutableArray array];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_emojiItemView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_emojiItemView)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_emojiItemView(30)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_emojiItemView)]];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollView)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scrollView]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollView)]];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_pageControl]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageControl)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_pageControl(20)]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageControl)]];
    [self addConstraints:temp];
}

- (void)loadEmoji:(NSArray *)arr {
    [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    scrollView.contentOffset = CGPointMake(0, 0);
    NSInteger count =  (NSInteger)(CGRectGetWidth([UIScreen mainScreen].bounds) - 40) / 44;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
        [bu setTitle:obj forState:UIControlStateNormal];
        [bu addTarget:self action:@selector(selectEmojiItem:) forControlEvents:UIControlEventTouchUpInside];
        bu.tag = idx + 100;
        bu.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [scrollView addSubview:bu];
        NSInteger H = (NSInteger)idx / count;
        H = H % 3;
        NSInteger page = idx / (3 * count);
        if (page) {
            idx = idx - count * 3 * page;
        }
        switch (H) {
            case 0:
                break;
            case 1:
                idx = idx - count;
                break;
            case 2:
                idx = idx - 2 * count;
                break;
                
            default:
                break;
        }
        bu.frame = CGRectMake(20 + idx * 44 + (page * CGRectGetWidth([UIScreen mainScreen].bounds) + 20), 35 * (H + .8), 44, 35);
    }];
    
    _pageControl.numberOfPages = ceilf(((CGFloat)arr.count / (CGFloat)(3 * count)));
    [scrollView setContentSize:CGSizeMake(ceilf(((CGFloat)arr.count / (CGFloat)(3 * count))) * CGRectGetWidth([UIScreen mainScreen].bounds), 0)];
}

- (void)selectEmojiItem:(UIButton *)button {
    if (_selectEmojiItemBlock) {
        _selectEmojiItemBlock(button.titleLabel.text);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollViews {
   [_pageControl setCurrentPage:(scrollViews.contentOffset.x / CGRectGetWidth([UIScreen mainScreen].bounds))];
//    if (ceilf(((CGFloat)scrollViews.contentOffset.x / (CGFloat)CGRectGetWidth([UIScreen mainScreen].bounds))) >= _pageControl.numberOfPages) {
//        [self loadEmoji:_emojiItemView.emojis[[_emojiItemView nextPage:1]]];
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
