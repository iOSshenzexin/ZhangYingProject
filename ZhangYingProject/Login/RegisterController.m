//
//  RegisterController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "RegisterController.h"
#import "ZXGetCheckCode.h"
@interface RegisterController ()

@end

@implementation RegisterController


+(RegisterController *)sharedRegisterController{
    static RegisterController *vc = nil;
    if (!vc) {
        vc = [[RegisterController alloc] init];
    }
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextField];
}

- (IBAction)didClickSelected:(id)sender {
    static BOOL isSelected = YES;
    self.selectBtn.selected = isSelected;
    isSelected = !isSelected;
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
    
    
    UIView *leftRecommendView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.recommendNumTF.frame.size.height)];
    UIImageView *leftRecommendImg = [[UIImageView alloc] init];
    leftRecommendImg.bounds = CGRectMake(0, 0, 18, 18);
    leftRecommendImg.center = leftRecommendView.center;
    [leftRecommendView addSubview:leftRecommendImg];
    leftRecommendImg.image = [UIImage imageNamed:@"my-code05"];
    self.recommendNumTF.leftView = leftRecommendView;
    self.recommendNumTF.leftViewMode = UITextFieldViewModeAlways;
    self.recommendNumTF.layer.borderColor = [color CGColor];
    self.recommendNumTF.layer.borderWidth = 1;
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

- (IBAction)didClickRegister:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    TabbarController *tab = (TabbarController *) application.keyWindow.rootViewController;
    tab.selectedIndex = self.selectedIndex;
    [MBProgressHUD showMessage:@"正在注册...."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self dismissViewControllerAnimated:YES completion:^{
            [MBProgressHUD showSuccess:@"恭喜你注册成功!"];
            AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
            app.isLogin = YES;
           
          //  [self.navigationController popViewControllerAnimated:NO];

        }];
    });
}

- (IBAction)didClickDelegate:(id)sender {
    
}
@end
