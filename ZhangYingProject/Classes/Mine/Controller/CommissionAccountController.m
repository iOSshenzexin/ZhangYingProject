//
//  CommissionAccountController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "CommissionAccountController.h"
#import "DealCustomCell.h"
@interface CommissionAccountController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *placeholderArray;
@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation CommissionAccountController


+(CommissionAccountController *)sharedCommissionAccountController{
    static CommissionAccountController *vc = nil;
    if (!vc) {
        vc = [[CommissionAccountController alloc] init];
    }
    return vc;
}

-(NSArray *)placeholderArray{
    if (!_placeholderArray) {
        _placeholderArray = [NSArray arrayWithObjects:@"请输入开户时的真实姓名",@"请仔细核对每一位数字",@"如招商银行",@"具体的开户支行", nil];
    }
    return _placeholderArray;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"账户名称",@"收款账户",@"银行名称",@"开户支行", nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.amountTableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.amountTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DealCustomCell *cell = [DealCustomCell cellWithTableView:tableView];
    cell.txtField.placeholder = self.placeholderArray[indexPath.row];
    cell.lbl.text = self.titleArray[indexPath.row];
    return cell;
}

- (IBAction)didClickSubmit:(id)sender {
    [self.view endEditing:YES];
    [MBProgressHUD showMessage:@"提交中......" toView:self.view];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    DealCustomCell *cellAccount = [self.amountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
     DealCustomCell *cellCard = [self.amountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
     DealCustomCell *cellName = [self.amountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
     DealCustomCell *cellBranch = [self.amountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    if ([self.registerAmount isEqualToString:@"registerAmount"]) {
        params[@"accountName"] = cellAccount.txtField.text;
        params[@"bankCard"] = cellCard.txtField.text;
        params[@"bankName"] = cellName.txtField.text;
        params[@"bankBranch"] = cellBranch.txtField.text;
        ZXLoginModel *model = AppLoginModel;
        params[@"memberId"] = model.mid;
        [manager POST:Mine_AddBankAccount_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUDForView:self.view];
            if([responseObject[@"status"]intValue] == 1){
                [MBProgressHUD showSuccess:@"提交成功!"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showError:@"提交失败,请重试!"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"提交失败,请检查网络!"];
        }];
    }else{
        params[@"accountName"] = cellAccount.txtField.text;
        params[@"bankCard"] = cellCard.txtField.text;
        params[@"bankName"] = cellName.txtField.text;
        params[@"bankBranch"] = cellBranch.txtField.text;
        ZXLoginModel *model = AppLoginModel;
        params[@"memberId"] = model.mid;
        [manager POST:Mine_AddBankAccount_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUDForView:self.view];
            if([responseObject[@"status"]intValue] == 1){
                [MBProgressHUD showSuccess:@"提交成功!"];
                [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
            }else{
                [MBProgressHUD showError:@"提交失败,请重试!"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"提交失败,请检查网络!"];
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUDForView:self.view];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
