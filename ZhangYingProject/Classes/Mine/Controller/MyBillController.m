//
//  MyBillController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyBillController.h"
#import "BankCardCell.h"

#import "ZXEnterRecordModel.h"
#define RowHeight 80
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
#warning  ruzhangjilu
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 108)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = RowHeight;
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
        _withdrawalsTableView.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
        _withdrawalsTableView.backgroundColor = [UIColor clearColor];
    }
    return _withdrawalsTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopSegment];
    /** 入账列表 */
    [self requestCommissionLog];
}

- (void)requestCommissionLog{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    [mgr POST:Mine_CommissionLog_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArray = [ZXEnterRecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        [self.tableView reloadData];
        ZXResponseObject
        
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
        NSLog(@"MyBillController: %d",index);
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
    BankCardCell *cell = [BankCardCell cellWithTableView:tableView];
    cell.recordModel = self.dataArray[indexPath.row];
    return cell;
}

@end
