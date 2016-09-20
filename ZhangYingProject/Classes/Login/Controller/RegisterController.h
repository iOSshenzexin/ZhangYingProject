//
//  RegisterController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterController : UIViewController
- (IBAction)didClickBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *telTF;
@property (weak, nonatomic) IBOutlet UITextField *checkCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *recommendNumTF;
- (IBAction)didClickRegister:(id)sender;

- (IBAction)didClickDelegate:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;


@property (nonatomic,assign) NSInteger selectedIndex;

+ (RegisterController *)sharedRegisterController;
@end
