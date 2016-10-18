//
//  ZXCommissionListController.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXCommissionListController.h"

#import "CommissionAccountController.h"
#import "ZXAmountListOneCell.h"
#import "ZXAmountListTwoCell.h"
#import "ZXAccountInfoModel.h"
@interface ZXCommissionListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ZXCommissionListController

+(ZXCommissionListController *)sharedZXCommissionListController{
    static ZXCommissionListController *vc = nil;
    if (!vc) {
        vc = [[ZXCommissionListController alloc] init];
    }
    return vc;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserCommissionAccount];
}


- (void)loadUserCommissionAccount
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    params[@"pageIndex"] = @0;
    [manager POST:Mine_BankAccountList_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArray = [ZXAccountInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络或服务器错误,请重试!"];
        ZXError
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 60;
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZXAmountListOneCell *cell = [ZXAmountListOneCell cellWithTableView:tableView];
        return cell;
    }else{
        ZXAmountListTwoCell *cell = [ZXAmountListTwoCell cellWithTableView:tableView];
        cell.updateBtn.tag = indexPath.row;
        [cell.updateBtn addTarget:self action:@selector(didClickUpdate:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.accountModel = self.dataArray[indexPath.row];
        return cell;
    }
}


- (void)didClickUpdate:(UIButton *)btn
{
    CommissionAccountController *vc = [[CommissionAccountController alloc] init];
    vc.title = @"结佣账户";
    vc.accountModel = self.dataArray[btn.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CommissionAccountController *vc = [[CommissionAccountController alloc] init];
        if (self.withdraw) {
            vc.registerAmount = @"withdraw";
        }
        
        vc.title = @"结佣账户";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        if (self.withdraw) {
            if ([self.delegate respondsToSelector:@selector(ZXCommissionListControllerDelegatePassAccountModel:)]) {
                self.accountModel = self.dataArray[indexPath.row];
                [self.delegate ZXCommissionListControllerDelegatePassAccountModel:self];
                 [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath * indexP =[NSIndexPath indexPathForRow:0 inSection:0];
    if (indexP == indexPath) {
        return NO;
    }
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteInternetAccountInfo:indexPath];
        
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)deleteInternetAccountInfo:(NSIndexPath *)indexPath{
    ZXAccountInfoModel *accountModel = self.dataArray[indexPath.row];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = accountModel.accountId;
    [manager POST: Mine_BankAccountListDelete_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZXResponseObject
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.view = nil;
}
@end
