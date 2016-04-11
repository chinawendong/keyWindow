//
//  FunctionView.h
//  keyWindow
//
//  Created by 云族佳 on 16/4/7.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionView : UIView

@property (nonatomic, copy) void (^pushPhotoAlbumBlock)();
+ (FunctionView *)defaultFunctionView;
@end
