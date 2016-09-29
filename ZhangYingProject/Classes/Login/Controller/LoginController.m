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

#import "UITextField+ZXTF.h"

@interface LoginController ()<UITextFieldDelegate>

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar removeFromSuperview];
    [self setUpTextField];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (IBAction)didClickLogin:(id)sender {
    BOOL isCorrectTelNumber;
    (self.telephoneTF.text.length != 11) ? ([MBProgressHUD showError:@"手机号码的长度不合要求!"]) : ((![ZXVerificationObject validateMobile:self.telephoneTF.text])?([MBProgressHUD showError:@"手机号码格式不合要求!"]):(isCorrectTelNumber = YES));
    if (isCorrectTelNumber) {
        if (self.pwdTF.text.length < 6 | self.pwdTF.text.length > 20) {
            [MBProgressHUD showError:@"密码的长度不合要求!"];
        }else{
            if (![ZXVerificationObject validatePassWord:self.pwdTF.text]) {
                [MBProgressHUD showError:@"密码格式不合要求!"];
            }else{
                [self loginAppwithUsernameAndPassword];
            }
        }
    }
 
    /*
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    app.isLogin = YES;
    UIApplication *application = [UIApplication sharedApplication];
    TabbarController *tab = (TabbarController *) application.keyWindow.rootViewController;
    tab.selectedIndex = self.selectedIndex;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self dismissViewControllerAnimated:YES completion:^{
            [MBProgressHUD showSuccess:@"恭喜你登录成功"];
        }];
    });
     */
}

- (void)loginAppwithUsernameAndPassword{
    [MBProgressHUD showMessage:@"登录中,请稍后...."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.telephoneTF.text;
    params[@"password"] = [self.pwdTF.text stringMD5Hash];
    [manager POST:Product_Login_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        if([responseObject[@"status"] intValue] == 1){
        ZXLoginModel *model = [ZXLoginModel mj_objectWithKeyValues:responseObject[@"data"]];
        [StandardUser setObject:[NSKeyedArchiver archivedDataWithRootObject:model] forKey:loginModel];
            
        AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
        app.isLogin = YES;
        
            if (app.selectedIndex ==0) {
                
            }else{
        UIApplication *application = [UIApplication sharedApplication];
        TabbarController *tab = (TabbarController *) application.keyWindow.rootViewController;
            
        tab.selectedIndex = app.selectedIndex;
        UIViewController *vc = tab.viewControllers[app.selectedIndex];
        [vc viewDidLoad];
        [vc.view setNeedsDisplay];

        [self.view endEditing:YES];
            }
        [self dismissViewControllerAnimated:YES completion:^{
            [MBProgressHUD showSuccess:@"恭喜你登录成功!"];
            [StandardUser setObject:self.pwdTF.text forKey:savePassword];
            [StandardUser synchronize];
        }];
        }else{
            [MBProgressHUD showError:@"用户名或者密码输入有误,请重试!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"登录失败,请检查网络!"];
    }];
    
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [MBProgressHUD hideHUD];
}

- (void)setUpTextField{
    UIColor *textFieldBorderColor = RGB(216, 216, 216, 0.8);
    
    [UITextField setupTextFieldImageView:self.telephoneTF image:[UIImage imageNamed:@"my-code03"] borderWidth:1 borderColor:textFieldBorderColor viewMode:UITextFieldViewModeAlways];
    
    [UITextField setupTextFieldImageView:self.pwdTF image:[UIImage imageNamed:@"my-code01"] borderWidth:1 borderColor:textFieldBorderColor viewMode:UITextFieldViewModeAlways];
    
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
    self.pwdTF.layer.borderColor = [textFieldBorderColor CGColor];
    self.pwdTF.layer.borderWidth = 1;
}

- (void)showPassWord:(UITapGestureRecognizer *)tap{
    self.pwdTF.secureTextEntry = !self.pwdTF.secureTextEntry;
}

-(void)viewWillAppear:(BOOL)animated{
   // [super viewWillAppear:YES];
    //self.navigationController.navigationBarHidden = YES;
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
        [self dismissViewControllerAnimated:YES completion:nil];    }
   }

- (IBAction)didClickRegister:(id)sender {
    RegisterController *vc = [RegisterController sharedRegisterController];
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
