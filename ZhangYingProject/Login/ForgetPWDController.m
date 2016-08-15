//
//  ForgetPWDController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ForgetPWDController.h"
#import "ZXGetCheckCode.h"
@interface ForgetPWDController ()

@end

@implementation ForgetPWDController


- (IBAction)didClickSetNewPWD:(id)sender {
    [MBProgressHUD showSuccess:@"新密码设置成功!"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextField];
}

- (void)setupTextField{
    UIView *leftTelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.telTF.frame.size.height)];
    UIImageView *leftTelImg = [[UIImageView alloc] init];
    leftTelImg.bounds = CGRectMake(0, 0, 18, 18);
    leftTelImg.center = leftTelView.center;
    [leftTelView addSubview:leftTelImg];
    leftTelImg.image = [UIImage imageNamed:@"my-code03"];
    self.telTF.leftView = leftTelView;
    self.telTF.leftViewMode = UITextFieldViewModeAlways;
    self.telTF.layer.borderWidth = 1;
    UIColor *color = RGB(216, 216, 216, 0.8);
    self.telTF.layer.borderColor = [color CGColor];
    
    UIView *leftCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.checkCodeTF.frame.size.height)];
    UIImageView *leftCodeImg = [[UIImageView alloc] init];
    leftCodeImg.bounds = CGRectMake(0, 0, 18, 18);
    leftCodeImg.center = leftTelImg.center;
    [leftCodeView addSubview:leftCodeImg];
    leftCodeImg.image = [UIImage imageNamed:@"my-code04"];
    self.checkCodeTF.leftView = leftCodeView;
    self.checkCodeTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, self.checkCodeTF.frame.size.height)];
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
    self.checkCodeTF.rightView = rightView;
    self.checkCodeTF.rightViewMode = UITextFieldViewModeAlways;
    
    self.checkCodeTF.layer.borderWidth = 1;
    self.checkCodeTF.layer.borderColor = [color CGColor];
    
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.pwdTF.frame.size.height)];
    UIImageView *leftImg = [[UIImageView alloc] init];
    leftImg.bounds = CGRectMake(0, 0, 18, 18);
    leftImg.center = leftView.center;
    [leftView addSubview:leftImg];
    leftImg.image = [UIImage imageNamed:@"my-code01"];
    self.pwdTF.leftView = leftView;
    self.pwdTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.pwdTF.frame.size.height)];
    UIImageView *rightImg = [[UIImageView alloc] init];
    rightImg.bounds = CGRectMake(0, 0, 20, 14);
    rightImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPassWord:)];
    [rightImg addGestureRecognizer:tap];
    rightImg.center = rightCodeView.center;
    [rightCodeView addSubview:rightImg];
    rightImg.image = [UIImage imageNamed:@"my-code02"];
    self.pwdTF.rightView = rightCodeView;
    self.pwdTF.rightViewMode = UITextFieldViewModeAlways;
    self.pwdTF.layer.borderColor = [color CGColor];
    self.pwdTF.layer.borderWidth = 1;
}


- (void)showPassWord:(UITapGestureRecognizer *)tap{
    static BOOL yesOrNo = NO;
    self.pwdTF.secureTextEntry = yesOrNo;
    yesOrNo = !yesOrNo;
}

- (void)getSMSCode:(UIButton *)btn{
    [ZXGetCheckCode getCheckCode:btn];
}

- (IBAction)didClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
