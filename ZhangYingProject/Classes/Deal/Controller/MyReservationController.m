//
//  MyReservationController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyReservationController.h"

#import "ZXReservationSuccessController.h"
#import "ZXReservationFailureController.h"
#import "ZXReservationWaitController.h"

#import "CustomOrderCell.h"
#import "ZXReservationModel.h"
@interface MyReservationController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *titleArray;
/**预约成功表格*/
@property (nonatomic,strong) UITableView *firstTableView;
/**待确认*/
@property (nonatomic,strong) UITableView *secondTableView;
/**预约失败*/
@property (nonatomic,strong) UITableView *thirdTableView;

@property (nonatomic,copy) NSArray *dataArray;

@end

@implementation MyReservationController

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


-(UITableView *)thirdTableView{
    if (!_thirdTableView) {
        _thirdTableView = [self setupTableview];
    }
    return _thirdTableView;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"待确认",@"预约成功",@"预约失败",nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopSegment];
    [self requestReservationLogWithUrl:Deal_MyDealList_Url ModelClassString:@"ZXReservationModel" TableView:self.firstTableView Status:1];
}

- (void)requestReservationLogWithUrl:(NSString *)url ModelClassString:(NSString *)modelString TableView:(UITableView *)tableView Status:(int)status{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    params[@"status"] = @(status);
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZXResponseObject
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
    UIView *view = (UIView *)contentArray[0];
    [view addSubview:self.firstTableView];
    UIView *viewSecond = (UIView *)contentArray[1];
    [viewSecond addSubview:self.secondTableView];
    UIView *viewThird = (UIView *)contentArray[2];
    [viewThird addSubview:self.thirdTableView];

    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) titleArray:self.titleArray contentViewArray:contentArray];
    scView.block = ^(int index){
        switch (index) {
            case 1:
                [self requestReservationLogWithUrl:Deal_MyDealList_Url ModelClassString:@"ZXReservationModel" TableView:self.firstTableView Status:index];
                break;
            case 2:
                [self requestReservationLogWithUrl:Deal_MyDealList_Url ModelClassString:@"ZXReservationModel" TableView:self.secondTableView Status:index];
                break;
            case 3:
                [self requestReservationLogWithUrl:Deal_MyDealList_Url ModelClassString:@"ZXReservationModel" TableView:self.thirdTableView Status:index];
                break;
            default:
                break;
        }
    };
    [self.view addSubview:scView];
}


#pragma mark UITableViewDelegate And UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomOrderCell *cell = [CustomOrderCell cellWithTableview:tableView];
    cell.reservationModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.firstTableView) {
        ZXReservationWaitController *vc = [[ZXReservationWaitController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.reservationModel = self.dataArray[indexPath.row];
        
        vc.title = @"预约待确认详情";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tableView == self.secondTableView){
    ZXReservationSuccessController *vc = [[ZXReservationSuccessController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.reservationModel = self.dataArray[indexPath.row];
    ZXLog(@"vc.reservationModel.cardnImage %@",vc.reservationModel.cardnImage);
    vc.title = @"预约成功详情";
    [self.navigationController pushViewController:vc animated:YES];
    }
    if (tableView == self.thirdTableView) {
        ZXReservationFailureController *vc = [[ZXReservationFailureController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.reservationModel = self.dataArray[indexPath.row];
        vc.title = @"预约失败详情";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
