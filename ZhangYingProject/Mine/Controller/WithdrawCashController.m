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

@interface WithdrawCashController ()<UITableViewDelegate,UITableViewDataSource,CommissionAccountControllerDelegate>

@end

@implementation WithdrawCashController

static NSString *cellID = @"cellId";
static NSString *cellString = @"cell";

static NSString *cellStyleThree = @"threecell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.withdrawCashTableView registerNib:[UINib nibWithNibName:@"WithdrawCashStyleOneCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self.withdrawCashTableView registerNib:[UINib nibWithNibName:@"WithdrawCashStyleTwoCell" bundle:nil] forCellReuseIdentifier:cellString];
    [self.withdrawCashTableView registerNib:[UINib nibWithNibName:@"WithdrawCashStyleThreeCell" bundle:nil] forCellReuseIdentifier:cellStyleThree];
    self.withdrawCashTableView.sectionFooterHeight = 0;
    self.withdrawCashTableView.sectionHeaderHeight = 0;
    [self deleteBack];
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIColor *color = RGB(216, 216, 216, 0.8);
    if (indexPath.row == 0) {
        if (self.changeCellStyle) {
            WithdrawCashStyleThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStyleThree];
            if (!cell) {
                cell = [[WithdrawCashStyleThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStyleThree];
            }
            cell.layer.borderWidth = 1;
            cell.layer.borderColor = [color CGColor];
            return cell;
        }else{
        WithdrawCashStyleTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
        if (!cell) {
            cell = [[WithdrawCashStyleTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
        }
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [color CGColor];
            return cell;
        }
    }
    WithdrawCashStyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
         cell = [[WithdrawCashStyleOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
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
    if (cardNumber != nil) {
        self.changeCellStyle = YES;
        self.withdrawCashBtn.backgroundColor = [UIColor redColor];
        [self.withdrawCashTableView reloadData];
    }
}

- (IBAction)didClickWithdrawCash:(id)sender {
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
