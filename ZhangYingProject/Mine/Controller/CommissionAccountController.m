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
    [self registerCell];
}

static NSString *cellID = @"cellId";
- (void)registerCell{
    UINib *nib = [UINib nibWithNibName:@"DealCustomCell" bundle:nil];
    [self.amountTableView registerNib:nib forCellReuseIdentifier:cellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DealCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DealCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    cell.layer.borderWidth = 1;
//    UIColor *color = [UIColor blackColor];
//    //RGB(242, 242, 242, 1);
//    cell.layer.borderColor = [color CGColor];
    cell.txtField.placeholder = self.placeholderArray[indexPath.row];
    cell.lbl.text = self.titleArray[indexPath.row];
    return cell;
}

@end
