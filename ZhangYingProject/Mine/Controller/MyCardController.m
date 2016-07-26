//
//  MyCardController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyCardController.h"
#import "CardCustomCell.h"

#import "RegularIntroduceController.h"
@interface MyCardController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *priceArray;
@property (nonatomic,copy) NSArray *timeArray;
@property (nonatomic,copy) NSArray *numberArray;
@property (nonatomic,copy) NSArray *amountArray;

@end

@implementation MyCardController

-(NSArray *)priceArray{
    if (!_priceArray) {
        _priceArray = [NSArray arrayWithObjects:@"¥100",@"¥200",@"¥500", nil];
    }
    return _priceArray;
}

-(NSArray *)timeArray{
    if (!_timeArray) {
        _timeArray = [NSArray arrayWithObjects:@"2016-05-01至2016-05-15",@"2016-05-10至2016-07-15",@"2016-08-01至2016-08-15", nil];
    }
    return _timeArray;
}

-(NSArray *)numberArray{
    if (!_numberArray) {
        _numberArray = [NSArray arrayWithObjects:@"券编号:4567890234",@"券编号:48878130234",@"券编号:2547800937", nil];
    }
    return _numberArray;
}

-(NSArray *)amountArray{
    if (!_amountArray) {
        _amountArray = [NSArray arrayWithObjects:@"认购金额100万起可用",@"认购金额300万起可用",@"认购金额500万起可用", nil];
    }
    return _amountArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRightBarBtn];
    [self registerCell];
    [self deleteBack];
    self.hidesBottomBarWhenPushed = YES;

}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}

static NSString *cellId = @"cellId";
- (void)registerCell{
    UINib *nib = [UINib nibWithNibName:@"CardCustomCell" bundle:nil];
    [self.cardTableView registerNib:nib forCellReuseIdentifier:cellId];
}
- (void)setupRightBarBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"规则说明" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickRegularIntrouduce:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)didClickRegularIntrouduce:(UIButton *)btn{
    RegularIntroduceController *vc = [[RegularIntroduceController alloc] init];
    vc.title = btn.titleLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.priceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[CardCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.priceLbl.text = self.priceArray[indexPath.row];
    cell.numberLbl.text = self.numberArray[indexPath.row];
    cell.amountLbl.text = self.amountArray[indexPath.row];
    cell.timeLbl.text = self.timeArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


@end
