//
//  MyCardController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyCardController.h"
#import "CardCustomCell.h"

#import "RegularIntroduceController.h"
#import "ZXCardModel.h"
@interface MyCardController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSMutableArray *dataArray;


@end

@implementation MyCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestMyCardListData];
    [self setupRightBarBtn];
}

- (void)requestMyCardListData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageIndex"] = 0;
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    [manager POST:Mine_MyCardList_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArray = [ZXCardModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        [self.cardTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}


- (void)setupRightBarBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"规则说明" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickRegularIntrouduce:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)didClickRegularIntrouduce:(UIButton *)btn{
    RegularIntroduceController *vc = [[RegularIntroduceController alloc] init];
    vc.title = btn.titleLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardCustomCell *cell = [CardCustomCell cellWithTableView:tableView];
    cell.cardModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


@end
