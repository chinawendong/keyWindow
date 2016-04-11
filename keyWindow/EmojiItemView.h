//
//  EmojiItemVIew.h
//  keyWindow
//
//  Created by 云族佳 on 16/4/6.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmojiItemView : UIView

@property (nonatomic, strong) NSArray *emojis;
@property (nonatomic, copy) void(^slectEmopjis)(NSInteger);
- (NSInteger)nextPage:(NSInteger)flag;

@end
