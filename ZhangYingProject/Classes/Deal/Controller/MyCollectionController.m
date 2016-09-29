//
//  MyCollectionController.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/29.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyCollectionController.h"
#import "ZXCollectionCell.h"
#import "ZXCollectionModel.h"

#import "ProductDetailController.h"
@interface MyCollectionController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSMutableArray *dataArray;


@end

@implementation MyCollectionController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestCollectionProductData];
}

- (void)requestCollectionProductData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    [manager POST:Deal_CollectionList_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArray = [ZXCollectionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXCollectionCell *cell = [ZXCollectionCell cellWithTableView:tableView];
    cell.collectionModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
     return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXCollectionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ProductDetailController *vc = [[ProductDetailController alloc] init];
    vc.title = cell.collectionModel.productTitle;
    ZXCollectionModel *product = self.dataArray[indexPath.row];
    vc.product_id = product.productId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
