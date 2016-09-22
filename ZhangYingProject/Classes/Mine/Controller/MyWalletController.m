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
    [self loadMyWalletInfomation];
}

-(void)loadMyWalletInfomation
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"mid"] = model.mid;
    [mgr POST:Mine_MyWalletContent_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.commissionLbl.text =[NSString stringWithFormat:@"%.2f",  [responseObject[@"data"][@"allCommision"]doubleValue] ];
        double alreadyMentionedCash = [responseObject[@"data"][@"allCommision"] doubleValue] - [responseObject[@"data"][@"commision"] doubleValue];
        self.alreadyMentionedLbl.text = [NSString stringWithFormat:@"%.2f",alreadyMentionedCash];
        self.canWithdrawLbl.text = [NSString stringWithFormat:@"%.2f",  [responseObject[@"data"][@"commision"]doubleValue]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
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
