//
//  EmojiItemVIew.m
//  keyWindow
//
//  Created by 云族佳 on 16/4/6.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import "EmojiItemView.h"

#import "MHEmoji.h"

@interface EmojiItem : UIButton

@end

@implementation EmojiItem

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIBezierPath *b = [UIBezierPath bezierPath];
    [b moveToPoint:CGPointMake(0, 5)];
    [b addLineToPoint:CGPointMake(0, CGRectGetHeight(rect) - 5)];
    [[UIColor blackColor]set];
    b.lineWidth = .1;
    [b stroke];
    
    UIBezierPath *b1 = [UIBezierPath bezierPath];
    [b1 moveToPoint:CGPointMake(CGRectGetWidth(rect), 5)];
    [b1 addLineToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) - 5)];
    b1.lineWidth = .1;
    [[UIColor blackColor]set];
    [b1 stroke];
}

@end

@interface EmojiItemView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *sendButton;


@end

@implementation EmojiItemView{
    UIButton *selectButton;
}

@synthesize scrollView,addButton,sendButton;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.emojis = [MHEmoji allMHEmoji];
        [self loadButton];
        [self loadScrollViewItem];
    }
    return self;
}

- (void)loadButton {
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [addButton setTitle:@"➕" forState:UIControlStateNormal];
    [self addSubview:addButton];
    
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.translatesAutoresizingMaskIntoConstraints = NO;
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self addSubview:sendButton];

    scrollView = [[UIScrollView alloc]init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollView];
    
    NSMutableArray *temp = [NSMutableArray array];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[addButton(44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(addButton)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[addButton(30)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(addButton)]];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[sendButton(44)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(sendButton)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[sendButton(30)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(sendButton)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[addButton]-0-[scrollView]-0-[sendButton]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(addButton,scrollView, sendButton)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[scrollView(30)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollView)]];
    [self addConstraints:temp];
}

- (void)loadScrollViewItem {

    
    [scrollView setContentSize:CGSizeMake(44 * (_emojis.count * 2 + 2), 0)];
    [_emojis enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = obj;
        EmojiItem *bu = [EmojiItem buttonWithType:UIButtonTypeCustom];
        [bu setTitle:arr.firstObject forState:UIControlStateNormal];
        [bu addTarget:self action:@selector(selectEmojiItems:) forControlEvents:UIControlEventTouchUpInside];
        bu.tag = idx + 100;
        bu.backgroundColor = [UIColor whiteColor];
        bu.frame = CGRectMake(idx * 44, 0, 44, 30);
        [scrollView addSubview:bu];
    }];
    
    [_emojis enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = obj;
        EmojiItem *bu = [EmojiItem buttonWithType:UIButtonTypeCustom];
        [bu setTitle:arr.firstObject forState:UIControlStateNormal];
        bu.backgroundColor = [UIColor whiteColor];
        bu.frame = CGRectMake((idx + _emojis.count) * 44, 0, 44, 30);
        [bu addTarget:self action:@selector(selectEmojiItems:) forControlEvents:UIControlEventTouchUpInside];
        bu.tag = idx + _emojis.count + 100;
        [bu addTarget:self action:@selector(selectEmojiItems:) forControlEvents:UIControlEventTouchUpInside];

        [scrollView addSubview:bu];
    }];
    
    selectButton = (UIButton *)[self viewWithTag:100];
    selectButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)selectEmojiItems:(UIButton *)button {
    if (_slectEmopjis) {
        _slectEmopjis((button.tag - 100) % _emojis.count);
    }
    selectButton.backgroundColor = [UIColor whiteColor];
    button.backgroundColor = [UIColor groupTableViewBackgroundColor];
    selectButton = button;
}

- (NSInteger)nextPage:(NSInteger)flag {
    
    NSInteger currIdx = (selectButton.tag - 100) % _emojis.count;
    selectButton.backgroundColor = [UIColor whiteColor];
    UIButton *button = (UIButton *)[self viewWithTag:currIdx + flag + 100];
    button.backgroundColor = [UIColor groupTableViewBackgroundColor];
    selectButton = button;
    return currIdx + flag;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
