//
//  RegisterController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "RegisterController.h"
#import "ZXGetCheckCode.h"

#import "UITextField+ZXTF.h"
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
    self.selectBtn.selected = !self.selectBtn.selected;
}


- (void)setupTextField{
    UIColor *textFieldBorderColor = RGB(216, 216, 216, 0.8);

    //手机号
    [UITextField setupTextFieldImageView:self.telTF image:[UIImage imageNamed:@"my-code03"] borderWidth:1 borderColor:textFieldBorderColor viewMode:UITextFieldViewModeAlways];
    //验证码
    [UITextField setupTextFieldImageView:self.checkCodeTF image:[UIImage imageNamed:@"my-code04"] borderWidth:1 borderColor:textFieldBorderColor viewMode:UITextFieldViewModeAlways];
    //密码
    [UITextField setupTextFieldImageView:self.pwdTF image:[UIImage imageNamed:@"my-code01"] borderWidth:1 borderColor:textFieldBorderColor viewMode:UITextFieldViewModeAlways];
    //邀请人
    [UITextField setupTextFieldImageView:self.recommendNumTF image:[UIImage imageNamed:@"my-code05"] borderWidth:1 borderColor:textFieldBorderColor viewMode:UITextFieldViewModeAlways];
    
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
    self.checkCodeTF.layer.borderColor = [textFieldBorderColor CGColor];
    
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
    self.pwdTF.layer.borderColor = [textFieldBorderColor CGColor];
    self.pwdTF.layer.borderWidth = 1;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)showPassWord:(UITapGestureRecognizer *)tap{
    self.pwdTF.secureTextEntry = !self.pwdTF.secureTextEntry;
}

- (void)getSMSCode:(UIButton *)btn{
    [ZXGetCheckCode getCheckCode:btn];
}

- (IBAction)didClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didClickRegister:(id)sender {
    BOOL isCorrectTelNumber;
    BOOL isCorrectCheckCode;
    (self.telTF.text.length != 11) ? ([MBProgressHUD showError:@"手机号码的长度不合要求!"]) : ((![ZXVerificationObject validateMobile:self.telTF.text])?([MBProgressHUD showError:@"手机号码格式不合要求!"]):(isCorrectTelNumber = YES));
    if (isCorrectTelNumber) {
        (self.checkCodeTF.text.length != 4) ? ([MBProgressHUD showError:@"验证码的长度不合要求!"]) : ((![ZXVerificationObject validateNumber:self.checkCodeTF.text])?([MBProgressHUD showError:@"验证码格式不合要求!"]):(isCorrectCheckCode = YES));
    }
    if (isCorrectCheckCode) {
        if (self.pwdTF.text.length < 6 | self.pwdTF.text.length > 20) {
            [MBProgressHUD showError:@"密码的长度不合要求!"];
        }else{
            if (![ZXVerificationObject validatePassWord:self.pwdTF.text]) {
                [MBProgressHUD showError:@"密码格式不合要求!"];
            }else{
                [self didFinishRegister];
            }
        }
    }
}


/**
 //如果有的话,判断被邀请的手机号码是否正确!
 if (self.recommendNumTF.text.length != 0){
 (self.recommendNumTF.text.length != 11) ? ([MBProgressHUD showError:@"邀请人手机号码的长度不合要求!"]) : ((![ZXVerificationObject validateMobile:self.recommendNumTF.text])?([MBProgressHUD showError:@"邀请人手机号码格式不合要求!"]):(nil));
 }
 */
#pragma mark - 点击注册按钮完成判断后需做的事情
- (void)didFinishRegister{
    [MBProgressHUD showMessage:@"正在注册...."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.telTF.text;
    params[@"password"] = [self.pwdTF.text stringMD5Hash];
    params[@"code"] = self.checkCodeTF.text ;
    [manager POST:Product_Register_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZXLog(@"%@",responseObject);
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] intValue] == 1) {
            AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
            app.isLogin = YES;
            UIApplication *application = [UIApplication sharedApplication];
            TabbarController *tab = (TabbarController *) application.keyWindow.rootViewController;
            tab.selectedIndex = app.selectedIndex;
            [self dismissViewControllerAnimated:YES completion:^{
                [MBProgressHUD showSuccess:@"恭喜你注册成功!"];
                //保存密码
                [StandardUser setObject:self.pwdTF.text forKey:savePassword];
                [StandardUser synchronize];
            }];
        }else{
            [MBProgressHUD showError:@"对不起,您没有注册成功!"];
        }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"注册失败!"];
            ZXLog(@"%@",error);
    }];
}

- (IBAction)didClickDelegate:(id)sender {
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [MBProgressHUD hideHUD];
}


@end
