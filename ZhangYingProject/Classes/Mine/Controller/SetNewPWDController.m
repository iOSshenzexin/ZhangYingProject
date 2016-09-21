//
//  SetNewPWDController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "SetNewPWDController.h"


@interface SetNewPWDController ()

@property (weak, nonatomic) IBOutlet UITextField *txtField;

@end

@implementation SetNewPWDController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTextField];
}

- (void)setUpTextField{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.txtField.frame.size.height)];
    UIImageView *leftImg = [[UIImageView alloc] init];
    leftImg.bounds = CGRectMake(0, 0, 18, 18);
    leftImg.center = leftView.center;
    [leftView addSubview:leftImg];
    leftImg.image = [UIImage imageNamed:@"my-code01"];
    self.txtField.leftView = leftView;
    self.txtField.leftViewMode = UITextFieldViewModeAlways;
    
    self.txtField.layer.borderWidth = 1;
    UIColor *color = RGB(216, 216, 216, 0.8);
    self.txtField.layer.borderColor = [color CGColor];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.txtField.frame.size.height)];
    UIImageView *rightImg = [[UIImageView alloc] init];
    rightImg.bounds = CGRectMake(0, 0, 20, 14);
    rightImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPassWord:)];
    [rightImg addGestureRecognizer:tap];
    rightImg.center = rightView.center;
    [rightView addSubview:rightImg];
    rightImg.image = [UIImage imageNamed:@"my-code02"];
    self.txtField.rightView = rightView;
    self.txtField.rightViewMode = UITextFieldViewModeAlways;
    
}

- (void)showPassWord:(UITapGestureRecognizer *)tap{
    self.txtField.secureTextEntry = !self.txtField.secureTextEntry;
}


- (IBAction)modifyPhoneNumber:(id)sender {
    
    if (self.txtField.text.length < 6 | self.txtField.text.length > 20) {
        [MBProgressHUD showError:@"密码的长度不合要求!"];
    }else{
        if (![ZXVerificationObject validatePassWord:self.txtField.text]) {
            [MBProgressHUD showError:@"密码格式不合要求!"];}
        else{
            [self.view endEditing:YES];
            [MBProgressHUD showMessage:@"正在修改密码....." toView:self.view];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            ZXLoginModel *model = AppLoginModel;
            params[@"password"] = [self.txtField.text stringMD5Hash];
            params[@"mid"] = model.mid;
            [manager POST:Mine_UpdatePassword_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                [MBProgressHUD hideHUDForView:self.view];
                if ([responseObject[@"status"] intValue] == 1) {
                    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
                    [MBProgressHUD showSuccess:@"密码修改成功!"];
                }
                else{
                    [MBProgressHUD showError:@"密码修改失败,请重试!"];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                ZXLog(@"%@",error);
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showError:@"网络错误,请重试!"];
            }];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


@end
