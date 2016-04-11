//
//  PhotoCell.m
//  PhotoControllerView
//
//  Created by 云族佳 on 16/4/8.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import "PhotoCell.h"


@interface PhotoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)button:(id)sender {
    self.types = _types == IconTypeSelectNome ? IconTypeSelect : IconTypeSelectNome;
    
    if (_select) {
        _select(self.types);
    }
}

- (void)setTypes:(IconType)type {
    _types = type;
    switch (type) {
        case IconTypeSelect:
            _icon.image = [UIImage imageNamed:@"icon-1460105698166"];
            break;
        case IconTypeSelectNome:
            _icon.image = [UIImage imageNamed:@"icon-1460105676885"];
            break;
        default:
            break;
    }

}

@end
