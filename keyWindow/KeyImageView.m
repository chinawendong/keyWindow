//
//  KeyImageView.m
//  keyWindow
//
//  Created by 云族佳 on 16/4/5.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import "KeyImageView.h"

#import "ExpressionView.h"

#import "FunctionView.h"

typedef NS_ENUM(NSUInteger, KeyboardMode) {
    KeyboardModeNome,
    KeyboardModeRecording,
    KeyboardModeEmoji,
    KeyboardModeAdd,
};

@interface KeyImageView ()<UITextViewDelegate>

@property (strong, nonatomic) NSLayoutConstraint *bomm;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UITextView *centenButton;
@property (strong, nonatomic) UIButton *centenButton1;
@property (strong, nonatomic) UIButton *rigthButton1;
@property (strong, nonatomic) UIButton *rigthButton2;
@property (nonatomic) KeyboardMode keyboardState;
@property (nonatomic, strong) ExpressionView *emojiView;
@property (nonatomic, strong) FunctionView *functionView;

@end

@implementation KeyImageView

- (void)loadCotification {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(show:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyBox:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setUpConstrints {
    self.backgroundColor = [UIColor lightGrayColor];
    self.userInteractionEnabled = YES;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1. constant:0];
    NSLayoutConstraint *rigth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1. constant:0];
    NSLayoutConstraint *higth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1000];
    self.bomm = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1. constant:1000-44];
    [self.superview addConstraints:@[left,rigth,higth,_bomm]];
}

- (void)loadUi {
    self.userInteractionEnabled = YES;
    self.leftButton = [UIButton new];
    _leftButton.translatesAutoresizingMaskIntoConstraints = NO;

    self.rigthButton1 = [UIButton new];
    _rigthButton1.translatesAutoresizingMaskIntoConstraints = NO;
    self.rigthButton2 = [UIButton new];
    _rigthButton2.translatesAutoresizingMaskIntoConstraints = NO;
    self.centenButton1 = [UIButton new];
    _centenButton1.translatesAutoresizingMaskIntoConstraints = NO;
    self.emojiView = [ExpressionView defaultExpressionView];
    _emojiView.translatesAutoresizingMaskIntoConstraints = NO;
    self.functionView = [FunctionView defaultFunctionView];
    _functionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_leftButton addTarget:self action:@selector(leftButtonMethods) forControlEvents:UIControlEventTouchUpInside];
    [_rigthButton1 addTarget:self action:@selector(rigth1ButtonMethods) forControlEvents:UIControlEventTouchUpInside];
    [_rigthButton2 addTarget:self action:@selector(rigth2ButtonMethods) forControlEvents:UIControlEventTouchUpInside];
    
    self.keyboardState = KeyboardModeNome;
    
    [self addSubview:_leftButton];
    [self addSubview:_rigthButton2];
    [self addSubview:_rigthButton1];
    [self addSubview:_centenButton1];
    [self addSubview:_emojiView];
    [self addSubview:_functionView];
    [self addSubview:self.centenButton];

    NSMutableArray *temp = [NSMutableArray array];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_leftButton(28)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftButton)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[_leftButton(28)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftButton)]];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rigthButton2(28)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rigthButton2)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[_rigthButton2(28)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rigthButton2)]];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rigthButton1(28)]-10-[_rigthButton2]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rigthButton1,_rigthButton2)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[_rigthButton1(28)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rigthButton1)]];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_leftButton]-10-[_centenButton]-10-[_rigthButton1]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftButton,_centenButton,_rigthButton1)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[_centenButton(26)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_centenButton)]];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_leftButton]-10-[_centenButton1]-10-[_rigthButton1]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftButton,_centenButton1,_rigthButton1)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[_centenButton1(28)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_centenButton1)]];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_emojiView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_emojiView)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(%@)-[_emojiView(200)]",@(44 + 200)] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_emojiView)]];
    
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_functionView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_functionView)]];
    [temp addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(%@)-[_functionView(200)]",@(44 + 200)] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_functionView)]];
    
    [self addConstraints:temp];
}

- (void)didMoveToSuperview {
    [self loadCotification];
    [self setUpConstrints];
    [self loadUi];
}

- (void)leftButtonMethods {

    if (_keyboardState != KeyboardModeNome && _keyboardState != KeyboardModeRecording) {
        self.keyboardState = KeyboardModeRecording;
    }else {
        _keyboardState == KeyboardModeNome ? ({
            self.keyboardState = KeyboardModeRecording;
        }): ({
            self.keyboardState = KeyboardModeNome;
        });
    }
}

- (void)rigth1ButtonMethods {
    
    if (_keyboardState != KeyboardModeNome && _keyboardState != KeyboardModeEmoji) {
        self.keyboardState = KeyboardModeEmoji;
    }else {
        _keyboardState == KeyboardModeNome ? ({
            self.keyboardState = KeyboardModeEmoji;
        }): ({
            self.keyboardState = KeyboardModeNome;
        });
    }
}

- (void)rigth2ButtonMethods {
    if (_keyboardState != KeyboardModeNome && _keyboardState != KeyboardModeAdd) {
        self.keyboardState = KeyboardModeAdd;
    }else {
        _keyboardState == KeyboardModeNome ? ({
            self.keyboardState = KeyboardModeAdd;
        }): ({
            self.keyboardState = KeyboardModeNome;
        });
    }
}

- (void)setKeyboardState:(KeyboardMode)keyboardState {
    _keyboardState = keyboardState;
    [_leftButton setImage:[UIImage imageNamed:@"dd_record_normal"] forState:UIControlStateNormal];
    [_rigthButton1 setImage:[UIImage imageNamed:@"dd_emotion"] forState:UIControlStateNormal];
    [_rigthButton2 setImage:[UIImage imageNamed:@"dd_utility"] forState:UIControlStateNormal];
    [_centenButton1 setBackgroundImage:[UIImage imageNamed:@"dd_press_to_say_normal"] forState:UIControlStateNormal];
    [_centenButton1 setBackgroundImage:[UIImage imageNamed:@"dd_record_release_end"] forState:UIControlStateHighlighted];
    _centenButton1.hidden = YES;
    _centenButton.hidden = NO;
    [self dismissEmojiView];
    [self dismissFunctionView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (keyboardState) {
            case KeyboardModeAdd:
                [_centenButton resignFirstResponder];
                [_rigthButton2 setImage:[UIImage imageNamed:@"dd_input_normal"] forState:UIControlStateNormal];
                [self showFunctionView];

                break;
            case KeyboardModeNome:
                [_centenButton becomeFirstResponder];
                break;
            case KeyboardModeEmoji:
                [_centenButton resignFirstResponder];
                [_rigthButton1 setImage:[UIImage imageNamed:@"dd_input_normal"] forState:UIControlStateNormal];
                [self showEmojiView];
                break;
            case KeyboardModeRecording:
                [_centenButton resignFirstResponder];
                [_leftButton setImage:[UIImage imageNamed:@"dd_input_normal"] forState:UIControlStateNormal];
                _centenButton1.hidden = NO;
                _centenButton.hidden = YES;
                [self hideKeyBox:nil];
                break;
            default:
                break;
        }
    });
    
}

- (void)show:(NSNotification *)notification {
    self.keyboardState = KeyboardModeNome;
    CGRect rect = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    [UIView animateWithDuration:.25 animations:^{
        [self layoutIfNeeded];
        self.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(rect));
    }];
}

- (void)hideKeyBox:(NSNotification *)notification {
    [UIView animateWithDuration:[notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue] animations:^{
        [self layoutIfNeeded];
        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)showEmojiView {
    self.emojiView.hidden = NO;
    self.functionView.hidden = YES;
    [UIView animateWithDuration:.25 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.transform = CGAffineTransformMakeTranslation(0, -200);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.25 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            _emojiView.transform = CGAffineTransformMakeTranslation(0, -200);
        }];
    }];
}

- (void)dismissEmojiView {
    self.emojiView.hidden = YES;
    [UIView animateWithDuration:.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        _emojiView.transform = CGAffineTransformIdentity;
    }];
}

- (void)showFunctionView {
    self.functionView.hidden = NO;
    self.emojiView.hidden = YES;
    [UIView animateWithDuration:.25 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.transform = CGAffineTransformMakeTranslation(0, -200);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.25 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            _functionView.transform = CGAffineTransformMakeTranslation(0, -200);
        }];
    }];
}

- (void)dismissFunctionView {
    self.functionView.hidden = YES;
    [UIView animateWithDuration:.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        _functionView.transform = CGAffineTransformIdentity;
    }];
}

-(UITextView *)centenButton {
    if (!_centenButton) {
        _centenButton = [UITextView new];
        _centenButton.translatesAutoresizingMaskIntoConstraints = NO;
        _centenButton.delegate = self;
        __weak typeof(_centenButton) weakCenten = _centenButton;
        [_emojiView setSelectEmojiItemBlock:^(NSString * string) {
            weakCenten.text = [weakCenten.text stringByAppendingString:string];
        }];
        
        [_centenButton addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _centenButton;
}

- (void)textViewDidChange:(UITextView *)textView {
//    [self getTextViewHigth:textView.text];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self getTextViewHigth:[change[@"new"] CGSizeValue].height];
}

- (void)getTextViewHigth:(CGFloat)idx {
 
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
