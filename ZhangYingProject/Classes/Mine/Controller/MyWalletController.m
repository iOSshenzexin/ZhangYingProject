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
        if ([responseObject[@"data"][@"allCommision"]doubleValue] / 10000 > 0) {
            self.commissionLbl.text = [NSString stringWithFormat:@"%.2f万",  [responseObject[@"data"][@"allCommision"]doubleValue]/10000.0];
        }else{
            self.commissionLbl.text =[NSString stringWithFormat:@"%.2f",  [responseObject[@"data"][@"allCommision"]doubleValue] ];
        }
        double alreadyMentionedCash = [responseObject[@"data"][@"allCommision"] doubleValue] - [responseObject[@"data"][@"commision"] doubleValue];
        self.alreadyMentionedLbl.text = [NSString stringWithFormat:@"%.2f",alreadyMentionedCash];
        
        if ([responseObject[@"data"][@"commision"]doubleValue] / 10000 > 0) {
             self.canWithdrawLbl.text = [NSString stringWithFormat:@"%.2f万",  [responseObject[@"data"][@"commision"]doubleValue]/10000.0];
        }else{
             self.canWithdrawLbl.text = [NSString stringWithFormat:@"%.2f",  [responseObject[@"data"][@"commision"]doubleValue]];
        }
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

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.view = nil;
}
@end
