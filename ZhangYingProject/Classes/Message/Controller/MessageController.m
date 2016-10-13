//
//  MessageController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MessageController.h"
#import "MessageCustomCell.h"

#import "MessageDetailController.h"
#import "ZXMessageModel.h"
@interface MessageController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSArray *dataArray;

@end

@implementation MessageController

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.messageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [self.messageTableView.mj_header beginRefreshing];
}

-(void)loadNewInfo
{
    [self requestMessageData];
}


- (void)requestMessageData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:Message_MessageList_Url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArray = [ZXMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.messageTableView reloadData];
        [self.messageTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCustomCell *cell = [MessageCustomCell cellWithTableView:tableView];
    cell.messageModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageDetailController *vc = [[MessageDetailController alloc] init];
    MessageCustomCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    vc.title = cell.titleLbl.text;
    vc.message_id = [self.dataArray[indexPath.row] message_id];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
