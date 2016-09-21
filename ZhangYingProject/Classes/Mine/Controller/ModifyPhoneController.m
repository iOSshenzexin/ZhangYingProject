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

+(ModifyPhoneController *)sharedModifyPhoneController{
    static ModifyPhoneController *vc = nil;
    if (!vc) {
        vc = [[ModifyPhoneController alloc] init];
    }
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTxtField];
}

- (IBAction)didClickBinding:(id)sender {
    BOOL isCorrectTelNumber;
    BOOL isCorrectCheckCode;
    (self.NumberTxt.text.length != 11) ? ([MBProgressHUD showError:@"手机号码的长度不合要求!"]) : ((![ZXVerificationObject validateMobile:self.NumberTxt.text])?([MBProgressHUD showError:@"手机号码格式不合要求!"]):(isCorrectTelNumber = YES));
    if (isCorrectTelNumber) {
        (self.verificationCodeTxt.text.length != 4) ? ([MBProgressHUD showError:@"验证码的长度不合要求!"]) : ((![ZXVerificationObject validateNumber:self.verificationCodeTxt.text])?([MBProgressHUD showError:@"验证码格式不合要求!"]):(isCorrectCheckCode = YES));
    }
    if(isCorrectCheckCode){
        [self completedBinding];
    }
}

- (void)completedBinding
{
    [self.view endEditing:YES];
    [MBProgressHUD showMessage:@"绑定中......"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.NumberTxt.text;
    ZXLoginModel *model = AppLoginModel;
    params[@"mid"] = model.mid;
    [manager POST:Mine_UpdatePhoneNumber_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        if([responseObject[@"status"]intValue] == 1){
        if ([self.delegate respondsToSelector:@selector(bindingPhoneNumber:)]) {
            [self.delegate bindingPhoneNumber:self];
        }
        [MBProgressHUD showSuccess:@"绑定成功!"];
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }else{
            [MBProgressHUD showError:@"绑定失败,请重试!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"绑定失败,请检查网络!"];
        ZXLog(@"%@",error);
    }];
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
    
    self.NumberTxt.layer.borderWidth = 1;
    UIColor *color = RGB(216, 216, 216, 0.8);
    self.NumberTxt.layer.borderColor = [color CGColor];
    
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
    
    self.verificationCodeTxt.layer.borderWidth = 1;
    self.verificationCodeTxt.layer.borderColor = [color CGColor];
}

- (void)getSMSCode:(UIButton *)btn{
    [ZXGetCheckCode getCheckCode:btn];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
