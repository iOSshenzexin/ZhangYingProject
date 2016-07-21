//
//  ModifyPhoneController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ModifyPhoneController.h"
#import "ZXGetCheckCode.h"
@interface ModifyPhoneController ()

@end

@implementation ModifyPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTxtField];
}

- (void)setupTxtField{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.NumberTxt.frame.size.height)];
    UIImageView *leftImg = [[UIImageView alloc] init];
    leftImg.bounds = CGRectMake(0, 0, 18, 18);
    leftImg.center = leftView.center;
    [leftView addSubview:leftImg];
    leftImg.image = [UIImage imageNamed:@"my-code03"];
    self.NumberTxt.leftView = leftView;
    self.NumberTxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.verificationCodeTxt.frame.size.height)];
    UIImageView *leftCodeImg = [[UIImageView alloc] init];
    leftCodeImg.bounds = CGRectMake(0, 0, 18, 18);
    leftCodeImg.center = leftView.center;
    [leftCodeView addSubview:leftCodeImg];
    leftCodeImg.image = [UIImage imageNamed:@"my-code04"];
    self.verificationCodeTxt.leftView = leftCodeView;
    self.verificationCodeTxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, self.verificationCodeTxt.frame.size.height)];
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.bounds = CGRectMake(0, 10, 100, 30);
    codeBtn.layer.cornerRadius = 5;
    [codeBtn setTitle: @"获取验证码" forState:UIControlStateNormal];
    [codeBtn addTarget:self action:@selector(getSMSCode:) forControlEvents:UIControlEventTouchUpInside];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [codeBtn setBackgroundColor:[UIColor redColor]];
    codeBtn.center = rightView.center;
    [rightView addSubview:codeBtn];
    self.verificationCodeTxt.rightView = rightView;
    self.verificationCodeTxt.rightViewMode = UITextFieldViewModeAlways;
}

- (void)getSMSCode:(UIButton *)btn{
    [ZXGetCheckCode getCheckCode:btn];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
