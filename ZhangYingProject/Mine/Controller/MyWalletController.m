//
//  MyWalletController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyWalletController.h"

#import "MyBillController.h"

#import "WithdrawCashController.h"
@interface MyWalletController ()

@end

@implementation MyWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRightBarBtn];
    [self deleteBack];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}

- (void)setupRightBarBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 30);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btn setTitle:@"账单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickMyBill:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)didClickMyBill:(UIButton *)btn{
    MyBillController *vc = [[MyBillController alloc] init];
    vc.title = btn.titleLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)didClickWithdrawCash:(id)sender {
    WithdrawCashController *vc = [[WithdrawCashController alloc] init];
    vc.title = @"提现";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
