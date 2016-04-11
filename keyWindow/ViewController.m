//
//  ViewController.m
//  keyWindow
//
//  Created by 云族佳 on 16/4/5.
//  Copyright © 2016年 云族佳. All rights reserved.
//

#import "ViewController.h"

#import "KeyImageView.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    UITextField *t = [[UITextField alloc]initWithFrame:CGRectMake(10, 64, 100, 20)];
    t.delegate = self;

    UIImageView *la = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 100,100)];
    [self.view addSubview:la];
    la.image = [UIImage imageNamed:@"221.gif"];
    [la startAnimating];
    [self.view addSubview:t];
    KeyImageView *k = [[KeyImageView alloc]init];
    [self.view addSubview:k];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
