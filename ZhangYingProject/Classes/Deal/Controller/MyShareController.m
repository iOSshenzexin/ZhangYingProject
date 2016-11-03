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

@property (nonatomic,strong) UITableView *shareTableView;

@property (nonatomic,strong) NSMutableArray *sharedArray;

@property(nonatomic,assign) int pageIndex;

@end

@implementation MyShareController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.shareTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.shareTableView.dataSource = self;
    self.shareTableView.delegate = self;
    self.shareTableView.rowHeight = 60;
    self.shareTableView.backgroundColor = backGroundColor;
    self.shareTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.shareTableView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.shareTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
    self.shareTableView.mj_header.automaticallyChangeAlpha = YES;
    self.shareTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfo)];
    [self.shareTableView.mj_header beginRefreshing];
}


-(void)loadNewInfo
{
    [self.sharedArray removeAllObjects];
    self.pageIndex = 0;
    [self requestSharedListContentWithType:0];
}

- (void)loadMoreInfo
{
    [self requestSharedListContentWithType:1];
}

- (void)requestSharedListContentWithType:(NSInteger)type
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    params[@"pageIndex"] = [NSNumber numberWithInt:self.pageIndex];
    ZXLog(@"pageIndex %zd",self.pageIndex);
    [manager POST:Deal_SharedList_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZXResponseObject;
        NSMutableArray *items = [ZXShareModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        if (type == 0) {
            self.sharedArray = items;
        }else{
            if (items.count == 0) {
                [MBProgressHUD showSuccess:@"已经是最后一页了"];
            }else{
                [self.sharedArray addObjectsFromArray:items];
            }
        }
        self.pageIndex ++;
        [self.shareTableView reloadData];
        [self.shareTableView.mj_header endRefreshing];
        [self.shareTableView.mj_footer endRefreshing];
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

        [self.shareTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
          [self.shareTableView reloadData];

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShareDetailController *vc = [[ShareDetailController alloc] init];
    ZXShareModel *model = self.sharedArray[indexPath.row];
    vc.product_id = model.productId;
    vc.productTitle = model.productTitle;
    vc.title = @"分享详情";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
