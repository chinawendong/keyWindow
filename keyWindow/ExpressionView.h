//
//  ExpressionView.h
//  keyWindow
//
//  Created by 云族佳 on 16/4/6.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressionView : UIView

@property (nonatomic, copy) void (^selectEmojiItemBlock)(NSString *);

+ (ExpressionView *)defaultExpressionView;

@end
