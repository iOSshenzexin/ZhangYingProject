//
//  LoginController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "LoginController.h"
#import "AppDelegate.h"
#import "TabbarController.h"

@interface LoginController ()<UIApplicationDelegate>

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (IBAction)didClickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        TabbarController *tc = [TabbarController sharedTabBarController];
        [tc setSelectedIndex:0];
    }];
   }
@end
