//
//  ChangePhoneController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ChangePhoneController.h"
#import "ModifyPhoneController.h"
@interface ChangePhoneController ()

@end

@implementation ChangePhoneController

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
    rightImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPassWord:)];
    [rightImg addGestureRecognizer:tap];
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
    static BOOL yesOrNo = NO;
    self.txtField.secureTextEntry = yesOrNo;
    yesOrNo = !yesOrNo;
}

- (IBAction)modifyPhoneNumber:(id)sender {
    ModifyPhoneController *vc = [ModifyPhoneController sharedModifyPhoneController];
    vc.title = @"更换绑定手机";
    [self.navigationController pushViewController:vc animated:YES];
    [self deleteBack];
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
