//
//  ProductAnnouncementController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductAnnouncementController.h"
#import "CustomAnnouncementCell.h"

#import "ZXAnnounceModel.h"
@interface ProductAnnouncementController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy) NSArray *titleArray;
/**
 *付息公告表格
 */
@property (nonatomic,strong) UITableView *firstTableView;

@property (nonatomic,strong) UITableView *secondTableView;


@property (nonatomic,copy) NSMutableArray *dataArray;


@end

@implementation ProductAnnouncementController

// 公告标题
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"付息公告",@"到期公告",nil];
    }
    return _titleArray;
}

- (UITableView *)createTableView
{
    UITableView *tableVeiw = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 130)];
    tableVeiw.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableVeiw.dataSource = self;
    tableVeiw.delegate = self;
    tableVeiw.rowHeight = 80;
    tableVeiw.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
    tableVeiw.backgroundColor = backGroundColor;
    tableVeiw.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    return tableVeiw;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopSegment];
    [self requestProductAnnouncementInfoWithUrl:Deal_ProductAnnounce_Url ModelClassString:@"ZXAnnounceModel" TableView:self.firstTableView Status:1];
}

- (void)requestProductAnnouncementInfoWithUrl:(NSString *)url ModelClassString:(NSString *)modelString TableView:(UITableView *)tableView Status:(int)status
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = @(status);
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArray = [NSClassFromString(modelString) mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    self.firstTableView = [self createTableView];
    [(UIView *)contentArray[0] addSubview:self.firstTableView];
    self.secondTableView = [self createTableView];
    [(UIView *)contentArray[1] addSubview:self.secondTableView];
    
    
    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) titleArray:self.titleArray contentViewArray:contentArray];
    scView.block = ^(int index){
        UITableView *tableView = [(UIView *)contentArray[index-1] subviews][0];
        [self requestProductAnnouncementInfoWithUrl:Deal_ProductAnnounce_Url ModelClassString:@"ZXAnnounceModel" TableView:tableView Status:index];
    };
    [self.view addSubview:scView];
}

#pragma mark UITableViewDelegate And UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomAnnouncementCell *cell = [CustomAnnouncementCell cellWithTableView:tableView];
    cell.announceModel = self.dataArray[indexPath.row];
    return cell;
}

@end
