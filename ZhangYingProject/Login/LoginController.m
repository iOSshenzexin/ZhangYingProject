//
//  LoginController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
#import "ForgetPWDController.h"
@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar removeFromSuperview];
    [self deleteBack];
    [self setUpTextField];
   // [self setupNavigationBarBtn];
}

- (void)setupNavigationBarBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"立即注册" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(didClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [btn setTitle:@"立即注册" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (IBAction)didClickLogin:(id)sender {
    [MBProgressHUD showMessage:@"登录中,请稍后...."];
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    app.isLogin = YES;
    UIApplication *application = [UIApplication sharedApplication];
    TabbarController *tab = (TabbarController *) application.keyWindow.rootViewController;
    tab.selectedIndex = self.selectedIndex;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self dismissViewControllerAnimated:YES completion:^{
            [MBProgressHUD showSuccess:@"恭喜你登录成功"];
        }];
    });
}


- (void)setUpTextField{
    UIView *leftTelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.telephoneTF.frame.size.height)];
    UIImageView *leftTelImg = [[UIImageView alloc] init];
    leftTelImg.bounds = CGRectMake(0, 0, 18, 18);
    leftTelImg.center = leftTelView.center;
    [leftTelView addSubview:leftTelImg];
    leftTelImg.image = [UIImage imageNamed:@"my-code03"];
    self.telephoneTF.leftView = leftTelView;
    self.telephoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.telephoneTF.layer.borderWidth = 1;
    UIColor *color = RGB(216, 216, 216, 0.8);
    self.telephoneTF.layer.borderColor = [color CGColor];
    
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.pwdTF.frame.size.height)];
    UIImageView *leftImg = [[UIImageView alloc] init];
    leftImg.bounds = CGRectMake(0, 0, 18, 18);
    leftImg.center = leftView.center;
    [leftView addSubview:leftImg];
    leftImg.image = [UIImage imageNamed:@"my-code01"];
    self.pwdTF.leftView = leftView;
    self.pwdTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.pwdTF.frame.size.height)];
    UIImageView *rightImg = [[UIImageView alloc] init];
    rightImg.bounds = CGRectMake(0, 0, 20, 14);
    rightImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPassWord:)];
    [rightImg addGestureRecognizer:tap];
    rightImg.center = rightView.center;
    [rightView addSubview:rightImg];
    rightImg.image = [UIImage imageNamed:@"my-code02"];
    self.pwdTF.rightView = rightView;
    self.pwdTF.rightViewMode = UITextFieldViewModeAlways;
    //UIColor *color = RGB(216, 216, 216, 0.8);
    self.pwdTF.layer.borderColor = [color CGColor];
    self.pwdTF.layer.borderWidth = 1;

}

- (void)showPassWord:(UITapGestureRecognizer *)tap{
    static BOOL yesOrNo = NO;
    self.pwdTF.secureTextEntry = yesOrNo;
    yesOrNo = !yesOrNo;
}

-(void)viewWillAppear:(BOOL)animated{
   // [super viewWillAppear:YES];
    //self.navigationController.navigationBarHidden = YES;
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}


- (IBAction)didClickBack:(id)sender {
    if (self.quit == 1) {
        UIApplication *application = [UIApplication sharedApplication];
        TabbarController *tab = (TabbarController *) application.keyWindow.rootViewController;
        tab.selectedIndex = 2;
        [self dismissViewControllerAnimated:YES completion:^{
        self.quit = 0;
        }];
    }else{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    }
    
   }

- (IBAction)didClickRegister:(id)sender {
    //RegisterController *vc = [[RegisterController alloc] init];
    RegisterController *vc = [RegisterController sharedRegisterController];
   // NSLog(@"%d",self.selectedIndex);
    if (self.selectedIndex != 0) {
        vc.selectedIndex = self.selectedIndex;  
    }
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)didClickSearchPwd:(id)sender {
    ForgetPWDController *vc = [[ForgetPWDController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
