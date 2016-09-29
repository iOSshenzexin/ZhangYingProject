//
//  WithdrawCashController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "WithdrawCashController.h"
#import "WithdrawCashStyleOneCell.h"
#import "WithdrawCashStyleTwoCell.h"
#import "WithdrawCashStyleThreeCell.h"
#import "CommissionAccountController.h"

#import "ZXAccountInfoModel.h"
@interface WithdrawCashController ()<UITableViewDelegate,UITableViewDataSource,CommissionAccountControllerDelegate>

@property (nonatomic,copy) NSMutableArray *accountListArray;

@property (nonatomic,copy) NSDictionary *defaultAccount;

@end

@implementation WithdrawCashController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.withdrawCashTableView.sectionFooterHeight = 0;
    self.withdrawCashTableView.sectionHeaderHeight = 0;
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.defaultAccount = nil;
    [self loadUserDefaultAccountList];

}

- (void)loadUserDefaultAccountList
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    [mgr POST: Mine_DefaultBankAccount_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] integerValue] == 1) {
            self.defaultAccount = responseObject[@"data"];
            self.isDefault = YES;
        }
        [self.withdrawCashTableView reloadData];
//        self.accountListArray = [ZXAccountInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        for (ZXAccountInfoModel *model in self.accountListArray) {
//            if (model.isDefault) {
//                self.isDefault = YES;
//            }
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.isDefault) {
            WithdrawCashStyleThreeCell *cell = [WithdrawCashStyleThreeCell cellWithTableView:tableView];
            cell.bankName.text = self.defaultAccount[@"bankName"];
            cell.cardNumber.text = self.defaultAccount[@"bankCard"];
            return cell;
        }else{
            WithdrawCashStyleTwoCell *cell = [WithdrawCashStyleTwoCell cellWithTableView:tableView];
            return cell;
        }
    }else{
        WithdrawCashStyleOneCell *cell = [WithdrawCashStyleOneCell cellWithTableView:tableView];
    return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        CommissionAccountController *vc = [[CommissionAccountController alloc] init];
        vc.registerAmount = @"registerAmount";
        vc.title = @"结佣账户";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark commissionAccountControllerDelegate
-(void)commissionAccountController:(CommissionAccountController *)vc andCardNumber:(NSString *)cardNumber cardStyle:(UIImage *)cardImage{
//    if (cardNumber != nil) {
//        self.changeCellStyle = YES;
//        self.withdrawCashBtn.backgroundColor = [UIColor redColor];
//        [self.withdrawCashTableView reloadData];
//    }
}

- (IBAction)didClickWithdrawCash:(id)sender {
    WithdrawCashStyleOneCell *cell = [self.withdrawCashTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    params[@"amount"] = cell.withdrawAmount.text;
    params[@"bankAccountId"] = self.defaultAccount[@"id"];
    
    [manager POST:Mine_WithdrawalApply_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] intValue] ==1) {
            [MBProgressHUD showSuccess:@"提交申请成功"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误,请稍后重试"];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.view = nil;
    [super viewDidDisappear:animated];
}

@end
