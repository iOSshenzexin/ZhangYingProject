//
//  MemberAuthenticationController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MemberAuthenticationController.h"
#import "CustomLine.h"
#import "AddImage.h"
@interface MemberAuthenticationController (){
}
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (weak, nonatomic) IBOutlet UITextField *nameTxt;

@property (weak, nonatomic) IBOutlet UITextField *memberIDTxt;
@end

@implementation MemberAuthenticationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView.layer.borderWidth = 1;
    UIColor *color = RGB(204, 204, 204, 0.8);
    self.backgroundView.layer.borderColor = [color CGColor];
    CustomLine *line = [[CustomLine alloc] init];
    line.frame = CGRectMake(15, self.backgroundView.bounds.size.height * 0.5, self.backgroundView.bounds.size.width -30, 1);
    line.backgroundColor = RGB(242/255.0, 242/255.0, 242/255.0, 0.3);
    [self.backgroundView addSubview:line];
    [self setupTxtFieldAndImage];
}

- (void)setupTxtFieldAndImage{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 120, self.nameTxt.frame.size.height)];
    UILabel *leftLbl = [[UILabel alloc] init];
    leftLbl.bounds = CGRectMake(0, 0, 80, self.nameTxt.frame.size.height);
    leftLbl.text = @"真实姓名";
    leftLbl.center = leftView.center;
    [leftView addSubview:leftLbl];
    self.nameTxt.leftView = leftView;
    self.nameTxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *memberView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 120, self.memberIDTxt.frame.size.height)];
    UILabel *memberLbl = [[UILabel alloc] init];
    memberLbl.bounds = CGRectMake(0, 0, 80, self.nameTxt.frame.size.height);
    memberLbl.text = @"身份证号";
    memberLbl.center = leftView.center;
    [memberView addSubview:memberLbl];
    self.memberIDTxt.leftView = memberView;
    self.memberIDTxt.leftViewMode = UITextFieldViewModeAlways;
    
    AddImage *picView = [[AddImage alloc] initWithFrame:CGRectMake(0, 10, 70*4, 60)];
    [self.pictureView addSubview:picView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
