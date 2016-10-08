//
//  ZXHomeProductController.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/10/8.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXHomeProductController.h"
#import "ZXProduct.h"
#import "ZXProductCell.h"
#import "ProductDetailController.h"
#import "LoginController.h"
@interface ZXHomeProductController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSMutableArray *productArray;
@end

@implementation ZXHomeProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestProductListContent];
}

- (void)requestProductListContent
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST: Product_List_Url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      self.productArray = [ZXProduct mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
    [self.productTableView reloadData];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         ZXError
     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXProductCell *cell = [ZXProductCell cellWithTableView:tableView];
    cell.product = self.productArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    if (app.isLogin) {
        ZXProductCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        ProductDetailController *vc = [[ProductDetailController alloc] init];
        vc.title = cell.product.productTitle;
        ZXProduct *product = self.productArray[indexPath.row];
        vc.product_id = product.proId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginController *login = [[LoginController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        [kWindowRootController presentViewController:nav animated:YES completion:nil];
    }
}



@end
