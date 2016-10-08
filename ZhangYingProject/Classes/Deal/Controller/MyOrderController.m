//
//  MyOrderController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyOrderController.h"
#import "CustomInTransitCell.h"

#import "ZXOrderUnderwayController.h"
#import "ZXOrderCompletedController.h"
#import "ZXOrderFailureController.h"

#import "ZXOrderModel.h"
@interface MyOrderController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy) NSArray *titleArray;
/**在途订单*/
@property (nonatomic,strong) UITableView *firstTableView;
/**交易成功*/
@property (nonatomic,strong) UITableView *secondTableView;
/**交易失败*/
@property (nonatomic,strong) UITableView *thirdTableView;

@property (nonatomic,copy) NSArray *dataArray;

@end

@implementation MyOrderController

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"在途订单",@"交易完成",@"交易失败",nil];
    }
    return _titleArray;
}

-(UITableView *)firstTableView{
    if (!_firstTableView) {
        _firstTableView = [self setupTableview];
    }
    return _firstTableView;
}

-(UITableView *)secondTableView{
    if (!_secondTableView) {
        _secondTableView = [self setupTableview];
    }
    return _secondTableView;
}

-(UITableView *)thirdTableView{
    if (!_thirdTableView) {
       _thirdTableView = [self setupTableview];
    }
    return _thirdTableView;
}

- (UITableView *)setupTableview{
    UITableView *customTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - topTitleMaxHeight)];
    customTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    customTV.dataSource = self;
    customTV.delegate = self;
    customTV.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
    customTV.backgroundColor = backGroundColor;
    customTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return customTV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopSegment];
    [self requestMyOrdeLogWithUrl:Deal_MyOrderList_Url ModelClassString:@"ZXOrderModel" TableView:self.firstTableView Status:1];
}

- (void)requestMyOrdeLogWithUrl:(NSString *)url ModelClassString:(NSString *)modelString TableView:(UITableView *)tableView Status:(int)status{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    params[@"status"] = @(status);
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArray = [NSClassFromString(modelString) mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        [tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}

- (void)setupTopSegment{
    self.automaticallyAdjustsScrollViewInsets= NO; //iOS7新增属性
    NSMutableArray *contentArray= [NSMutableArray array];
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        UIView *view= [[UIView alloc] init];
        view.backgroundColor = RGB(242, 242, 242, 1);
        [contentArray addObject:view];
    }
    //在途
    [(UIView *)contentArray[0] addSubview:self.firstTableView];
    //交易成功
    [(UIView *)contentArray[1] addSubview:self.secondTableView];
    //交易失败
    [(UIView *)contentArray[2] addSubview:self.thirdTableView];
    
    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) titleArray:self.titleArray contentViewArray:contentArray];
    [self.view addSubview:scView];

    scView.block = ^(int index,CGFloat off){
        switch (index) {
            case 1:
                [self requestMyOrdeLogWithUrl:Deal_MyOrderList_Url ModelClassString:@"ZXOrderModel" TableView:self.firstTableView Status:index];
                break;
            case 2:
                [self requestMyOrdeLogWithUrl:Deal_MyOrderList_Url ModelClassString:@"ZXOrderModel" TableView:self.secondTableView Status:index];
                break;
            case 3:
                [self requestMyOrdeLogWithUrl:Deal_MyOrderList_Url ModelClassString:@"ZXOrderModel" TableView:self.thirdTableView Status:index];
                break;
            default:
                break;
        }
    };
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.firstTableView){
        ZXOrderUnderwayController *vc = [[ZXOrderUnderwayController alloc] init];
        vc.orderModel = self.dataArray[indexPath.row];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = @"在途订单详情";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tableView == self.secondTableView) {
        ZXOrderCompletedController *vc = [[ZXOrderCompletedController alloc] init];
        vc.orderModel = self.dataArray[indexPath.row];

        vc.hidesBottomBarWhenPushed = YES;
        vc.title = @"订单交易完成详情";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tableView == self.thirdTableView) {
        ZXOrderFailureController *vc = [[ZXOrderFailureController alloc] init];
        vc.orderModel = self.dataArray[indexPath.row];

        vc.hidesBottomBarWhenPushed = YES;
        vc.title = @"订单交易失败详情";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomInTransitCell *cell = [CustomInTransitCell cellWithTableview:tableView];
    cell.orderModel = self.dataArray[indexPath.row];
    return cell;
}

@end
