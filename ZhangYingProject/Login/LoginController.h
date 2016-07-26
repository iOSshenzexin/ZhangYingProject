//
//  LoginController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController
- (IBAction)didClickBack:(id)sender;
- (IBAction)didClickRegister:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *telephoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
- (IBAction)didClickSearchPwd:(id)sender;

@property (nonatomic,assign) NSInteger selectedIndex;
//如果为1,说明正式退出
@property (nonatomic,assign) NSInteger quit;

@end
