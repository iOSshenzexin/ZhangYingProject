//
//  MyBillController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyBillController.h"
#import "BankCardCell.h"
#import "ZXWithdrawCell.h"

#import "ZXEnterRecordModel.h"
#import "ZXWithdrawRecordModel.h"
@interface MyBillController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy) NSArray *titleArray;

@property (nonatomic,strong) UITableView *tableView;
//提现表格
@property (nonatomic,strong) UITableView *withdrawalsTableView;


@property (nonatomic,copy) NSMutableArray *dataArray;
@end

@implementation MyBillController

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"入账记录",@"提现记录", nil];
    }
    return _titleArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 108)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 80;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
        _tableView.backgroundColor = backGroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _tableView;
}

-(UITableView *)withdrawalsTableView{
    if (!_withdrawalsTableView) {
        _withdrawalsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 108)];
        _withdrawalsTableView.dataSource = self;
        _withdrawalsTableView.delegate = self;
        _withdrawalsTableView.rowHeight = 124;
        _withdrawalsTableView.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
        _withdrawalsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _withdrawalsTableView.backgroundColor = self.view.backgroundColor;
    }
    return _withdrawalsTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopSegment];
    /** 入账列表 */
    [self requestCommissionLogWithUrl:Mine_CommissionLog_Url ModelClassString:@"ZXEnterRecordModel" TableView:self.tableView];
}

- (void)requestCommissionLogWithUrl:(NSString *)url ModelClassString:(NSString *)modelString TableView:(UITableView *)tableView{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArray = [NSClassFromString(modelString) mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        [tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
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
    scView.block = ^(int index){
        (index == 1)?([self requestCommissionLogWithUrl:Mine_CommissionLog_Url ModelClassString:@"ZXEnterRecordModel" TableView:self.tableView]):([self requestCommissionLogWithUrl:Mine_WithdrawLog_Url ModelClassString:@"ZXWithdrawRecordModel" TableView:self.withdrawalsTableView]);
    };
    
    [self.view addSubview:scView];
    UIView *view = (UIView *)contentArray[0];
    [view addSubview:self.tableView];
    UIView *secondView = (UIView *)contentArray[1];
    [secondView addSubview:self.withdrawalsTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        BankCardCell *cell = [BankCardCell cellWithTableView:tableView];
        cell.recordModel = self.dataArray[indexPath.row];
        return cell;
    }
    ZXWithdrawCell *cell = [ZXWithdrawCell cellWithTableView:tableView];
    cell.withdrawRecordModel = self.dataArray[indexPath.row];
    return cell;
}

@end
