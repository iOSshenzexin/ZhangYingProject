//
//  MyBillController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyBillController.h"
#import "BankCardCell.h"

#define RowHeight 100
@interface MyBillController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy) NSArray *titleArray;
@property (nonatomic,strong) UITableView *tableView;
//提现表格
@property (nonatomic,strong) UITableView *withdrawalsTableView;
@property (nonatomic,copy) NSArray *bankIconImageArray;

@end

@implementation MyBillController

-(NSArray *)bankIconImageArray{
    if (!_bankIconImageArray) {
        _bankIconImageArray = [NSArray arrayWithObjects:@"bank01",@"bank02",@"bank03",@"bank02",@"bank01", nil];
    }
    return _bankIconImageArray;
}


 static NSString *str = @"cellId";
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 108)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = RowHeight;
       [_tableView registerNib:[UINib nibWithNibName:@"BankCardCell" bundle:nil] forCellReuseIdentifier:str];
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

-(UITableView *)withdrawalsTableView{
    if (!_withdrawalsTableView) {
        _withdrawalsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 108)];
        _withdrawalsTableView.dataSource = self;
        _withdrawalsTableView.delegate = self;
        _withdrawalsTableView.rowHeight = RowHeight;
        [_withdrawalsTableView registerNib:[UINib nibWithNibName:@"BankCardCell" bundle:nil] forCellReuseIdentifier:str];
        _withdrawalsTableView.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
        _withdrawalsTableView.backgroundColor = [UIColor clearColor];
    }
    return _withdrawalsTableView;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"入账记录",@"提现记录", nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopSegment];
}

- (void)setupTopSegment{
    self.automaticallyAdjustsScrollViewInsets = NO; //iOS7新增属性
    NSMutableArray *contentArray= [NSMutableArray array];
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        UIView *view=[[UIView alloc] initWithFrame:self.view.frame];
        view.backgroundColor = RGB(242, 242, 242, 1);
        [contentArray addObject:view];
    }
    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) titleArray:self.titleArray contentViewArray:contentArray];
    [self.view addSubview:scView];
    
    UIView *view = (UIView *)contentArray[0];
    [view addSubview:self.tableView];
    UIView *secondView = (UIView *)contentArray[1];
    [secondView addSubview:self.withdrawalsTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[BankCardCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.iconImage.image = [UIImage imageNamed:self.bankIconImageArray[indexPath.row]];
    cell.layer.borderWidth = 3;
    UIColor *color = RGB(242, 242, 242, 1);
    cell.layer.borderColor = [color CGColor];
    return cell;
}


@end
