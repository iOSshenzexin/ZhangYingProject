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
@end

@implementation WithdrawCashController

static NSString *cellID = @"cellId";
static NSString *cellString = @"cell";

static NSString *cellStyleThree = @"threecell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserBandAccountList];
    [self.withdrawCashTableView registerNib:[UINib nibWithNibName:@"WithdrawCashStyleOneCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self.withdrawCashTableView registerNib:[UINib nibWithNibName:@"WithdrawCashStyleTwoCell" bundle:nil] forCellReuseIdentifier:cellString];
    [self.withdrawCashTableView registerNib:[UINib nibWithNibName:@"WithdrawCashStyleThreeCell" bundle:nil] forCellReuseIdentifier:cellStyleThree];
    self.withdrawCashTableView.sectionFooterHeight = 0;
    self.withdrawCashTableView.sectionHeaderHeight = 0;
}

- (void)loadUserBandAccountList
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    [mgr POST: Mine_BankAccountList_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.accountListArray = [ZXAccountInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (ZXAccountInfoModel *model in self.accountListArray) {
            if (model.isDefault) {
                self.isDefault = YES;
            }
        }
        ZXResponseObject
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
    UIColor *color = RGB(216, 216, 216, 0.8);
    if (indexPath.section == 0) {
        if (self.isDefault) {
            WithdrawCashStyleThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStyleThree];
            if (!cell) {
                cell = [[WithdrawCashStyleThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStyleThree];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.layer.borderWidth = 1;
            cell.layer.borderColor = [color CGColor];
            return cell;
        }else{
            WithdrawCashStyleTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
            if (!cell) {
                cell = [[WithdrawCashStyleTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.layer.borderWidth = 1;
            cell.layer.borderColor = [color CGColor];
            return cell;
        }
        }
    WithdrawCashStyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
         cell = [[WithdrawCashStyleOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [color CGColor];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        CommissionAccountController *vc = [CommissionAccountController sharedCommissionAccountController];
        vc.delegate = self;
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
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
