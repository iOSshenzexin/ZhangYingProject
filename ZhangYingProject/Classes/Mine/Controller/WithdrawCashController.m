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

#import "ZXCommissionListController.h"
#import "CommissionAccountController.h"

#import "ZXAccountInfoModel.h"
@interface WithdrawCashController ()<UITableViewDelegate,UITableViewDataSource,CommissionAccountControllerDelegate,ZXCommissionListControllerDelegate>

@property (nonatomic,copy) NSMutableArray *accountListArray;

@property (nonatomic,copy) NSDictionary *defaultAccount;

@property (nonatomic,copy) NSArray *accountSelected;

@end

@implementation WithdrawCashController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.withdrawCashTableView.sectionFooterHeight = 0;
    self.withdrawCashTableView.sectionHeaderHeight = 0;
    ZXCommissionListController *vc = [ZXCommissionListController sharedZXCommissionListController];
    vc.delegate = self;
    
}

-(void)ZXCommissionListControllerDelegatePassAccountModel:(ZXCommissionListController *)vc
{
    self.accountSelected = [NSArray arrayWithObjects:vc.accountModel.bankName,vc.accountModel.bankCard,vc.accountModel.accountId,nil];
    
//    self.isDefault = YES;
    
    [self.withdrawCashTableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isDefault = YES;

    if (self.accountSelected.count != 0) {
        
    }else
    {
    self.accountSelected = nil;
    self.defaultAccount = nil;
    [self loadUserDefaultAccountList];
    }
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
            if (self.accountSelected.count != 0) {
                cell.bankName.text = self.accountSelected[0];
                cell.cardNumber.text = self.accountSelected[1];
            }else{
                if (self.defaultAccount != nil) {
                    cell.bankName.text = self.defaultAccount[@"bankName"];
                    cell.cardNumber.text = self.defaultAccount[@"bankCard"];
                }else{
                    WithdrawCashStyleTwoCell *cell = [WithdrawCashStyleTwoCell cellWithTableView:tableView];
                    return cell;
                }
            }
            return cell;
        }
    }
    WithdrawCashStyleOneCell *cell = [WithdrawCashStyleOneCell cellWithTableView:tableView];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        ZXCommissionListController *vc = [ZXCommissionListController sharedZXCommissionListController];
        vc.withdraw = @"withdraw";
        vc.title = @"结佣账号列表";
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
    if ([cell.withdrawAmount.text doubleValue] == 0) {
         [MBProgressHUD showError:@"提现金额不可为空!"];
    }
    else if ([cell.withdrawAmount.text doubleValue] > [self.amount doubleValue]) {
        [MBProgressHUD showError:@"对不起,提现金额超出可提现金额!"];
    }else{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    params[@"amount"] = cell.withdrawAmount.text;
        if (self.accountSelected) {
            params[@"bankAccountId"] = self.accountSelected[2];
        }else{
            params[@"bankAccountId"] = self.defaultAccount[@"id"];
        }
    
    [manager POST:Mine_WithdrawalApply_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] intValue] ==1) {
            [MBProgressHUD showSuccess:@"提交申请成功"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络或服务器错误,请稍后重试!"];
    }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
   
    [super viewDidDisappear:animated];
    self.view = nil;
    self.accountSelected = nil;
}

@end
