//
//  ChangeLoginNumberController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ChangeLoginNumberController.h"

#import "SetNewPWDController.h"
@interface ChangeLoginNumberController ()

@end

@implementation ChangeLoginNumberController

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
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, self.txtField.frame.size.height)];
    UIImageView *rightImg = [[UIImageView alloc] init];
    rightImg.bounds = CGRectMake(0, 0, 20, 14);
    rightView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPassWord:)];
    [rightView addGestureRecognizer:tap];
    rightImg.center = rightView.center;
    [rightView addSubview:rightImg];
    rightImg.image = [UIImage imageNamed:@"my-code02"];
    self.txtField.rightView = rightView;
    self.txtField.rightViewMode = UITextFieldViewModeAlways;
    
    self.txtField.layer.borderWidth = 1;
    UIColor *color = RGB(216, 216, 216, 0.8);
    self.txtField.layer.borderColor = [color CGColor];
}

- (void)showPassWord:(UITapGestureRecognizer *)tap{
    self.txtField.secureTextEntry = !self.txtField.secureTextEntry ;
}

- (IBAction)modifyPhoneNumber:(id)sender {
    if (self.txtField.text.length < 6 | self.txtField.text.length > 20) {
        [MBProgressHUD showError:@"密码的长度不合要求!"];
    }else{
        if (![ZXVerificationObject validatePassWord:self.txtField.text]) {
            [MBProgressHUD showError:@"密码格式不合要求!"];
        }else if([self.txtField.text isEqualToString:[StandardUser objectForKey:savePassword]]){
            SetNewPWDController *vc = [[SetNewPWDController alloc] init];
            vc.title = @"修改登录密码";
            [self.navigationController pushViewController:vc animated:YES];        }else{
            [MBProgressHUD showError:@"原密码输入错误!"];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


@end
