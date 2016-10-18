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

@property (nonatomic,copy) NSArray *userInfo;

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
        _placeholderArray = [NSArray arrayWithObjects:@"请输入开户时的真实姓名",@"如招商银行",@"请仔细核对每一位数字",@"具体的开户支行", nil];
    }
    return _placeholderArray;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"账户名称:",@"银行名称:",@"收款账户:",@"开户支行:", nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.amountTableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.amountTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (self.accountModel) {
        [self.submitBtn setTitle:@"修改账户" forState:UIControlStateNormal];
        self.userInfo = [NSArray arrayWithObjects:self.accountModel.accountName,self.accountModel.bankName,self.accountModel.bankCard,self.accountModel.bankBranch, nil];
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DealCustomCell *cell = [DealCustomCell cellWithTableView:tableView];
    cell.txtField.placeholder = self.placeholderArray[indexPath.row];
    if (self.accountModel) {
      cell.txtField.text = self.userInfo[indexPath.row];
    }
    cell.lbl.text = self.titleArray[indexPath.row];
    return cell;
}

- (IBAction)didClickSubmit:(id)sender {
    [self.view endEditing:YES];
    DealCustomCell *cellAccount = [self.amountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    DealCustomCell *cellCard = [self.amountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    DealCustomCell *cellName = [self.amountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    DealCustomCell *cellBranch = [self.amountTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString *urlString;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    if (self.accountModel) {
        urlString = Mine_BankAccountListUpdate_Url;
        params[@"accountName"] = cellAccount.txtField.text;
        params[@"bankCard"] = cellCard.txtField.text;
        params[@"bankName"] = cellName.txtField.text;
        params[@"bankBranch"] = cellBranch.txtField.text;
        params[@"id"] = self.accountModel.accountId;
        ZXLoginModel *model = AppLoginModel;
        params[@"memberId"] = model.mid;
    }else{
        urlString = Mine_AddBankAccount_Url;
        params[@"accountName"] = cellAccount.txtField.text;
        params[@"bankCard"] = cellCard.txtField.text;
        params[@"bankName"] = cellName.txtField.text;
        params[@"bankBranch"] = cellBranch.txtField.text;
        ZXLoginModel *model = AppLoginModel;
        params[@"memberId"] = model.mid;
    }
    
    if (cellAccount.txtField.text.length == 0 |cellCard.txtField.text.length == 0 |cellName.txtField.text.length == 0|cellBranch.txtField.text.length == 0) {
        [MBProgressHUD showError:@"所填内容不可为空!"];
    }else{
    [MBProgressHUD showMessage:@"提交中......" toView:self.view];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ZXLog(@"%@",params);
    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUDForView:self.view];
            if([responseObject[@"status"]intValue] == 1){
                [MBProgressHUD showSuccess:@"提交成功!"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showError:@"此结佣账户已经存在!"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"提交失败,网络或服务器错误!"];
        }];
    }
    if (self.registerAmount) {
        NSInteger count = self.navigationController.viewControllers.count;
        [self.navigationController popToViewController:self.navigationController.viewControllers[count - 3] animated:YES];
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
