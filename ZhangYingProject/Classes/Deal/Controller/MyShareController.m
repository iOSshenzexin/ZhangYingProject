//
//  MyShareController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyShareController.h"

#import "CustomShareCell.h"
#import "ShareDetailController.h"

#import "ZXShareModel.h"
@interface MyShareController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *firstTableView;

@property (nonatomic,copy) NSMutableArray *sharedArray;

@end

@implementation MyShareController

-(UITableView *)firstTableView{
    if (!_firstTableView) {
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _firstTableView.dataSource = self;
        _firstTableView.delegate = self;
        _firstTableView.rowHeight = 80;
        _firstTableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _firstTableView.backgroundColor = backGroundColor;
        _firstTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _firstTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestSharedListContent];
    [self.view addSubview:self.firstTableView];
}


- (void)requestSharedListContent
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    params[@"pageIndex"] = @(0);
    [manager POST:Deal_SharedList_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.sharedArray = [ZXShareModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        [self.firstTableView reloadData];
        ZXResponseObject
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sharedArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomShareCell *cell = [CustomShareCell cellWithTableView:tableView];
    cell.shareModel = self.sharedArray[indexPath.row];
      return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            [self.sharedArray removeObjectAtIndex:indexPath.row];
            [self.firstTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.firstTableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    ShareDetailController *vc = [[ShareDetailController alloc] init];
    vc.title = @"分享详情";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
