//
//  AddAdressController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "AddAdressController.h"

#import "AddressCustomCell.h"

#import "DeliveryAddressController.h"

#import "ZXAddressModel.h"
@interface AddAdressController ()<UITableViewDelegate,UITableViewDataSource,DeliveryAddressControllerDelegate>

@property (nonatomic,copy) NSMutableArray *titleArray;

@end

@implementation AddAdressController


-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *firstArray = [NSMutableArray arrayWithObject:@" 新增收货地址"];
    [self.titleArray addObject:firstArray];
    [self setupTableView];
    [self loadAdressData];
}

- (void)setupTableView
{
    self.addressTableVeiw.sectionFooterHeight = 15;
    self.addressTableVeiw.sectionHeaderHeight = 0;
    self.addressTableVeiw.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}


- (void)loadAdressData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    params[@"pageIndex"] = @0;
    [manager POST:Mine_AddressList_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZXResponseObject
        if ([responseObject[@"status"] intValue] == 1) {
            [self.titleArray addObject:[ZXAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]]];
            [self.addressTableVeiw reloadData];
            }
        else{
            [MBProgressHUD showError:@"请求失败!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络或服务器错误,请重试!"];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titleArray[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCustomCell *cell = [AddressCustomCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.img.image = [UIImage imageNamed:@"my-trade03"];
        cell.titleLabel.text = self.titleArray[indexPath.section][indexPath.row];
        cell.nameLbl.hidden = YES;
        cell.phoneLbl.hidden = YES;
        cell.btn.hidden = YES;
        cell.titleLabel.textColor = [UIColor redColor];
    }else if(indexPath.section == 1){
        cell.address = self.titleArray[indexPath.section][indexPath.row];
        cell.img.image = [UIImage imageNamed:@"my-trade05"];
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath * indexP =[NSIndexPath indexPathForRow:0 inSection:0];
    if (indexP == indexPath) {
        return NO;
    }
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteInternetAddressInfo:indexPath];
        [self.titleArray[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.addressTableVeiw deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.addressTableVeiw reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
/**
 * 删除地址信息
 */
- (void)deleteInternetAddressInfo:(NSIndexPath *)indexPath
{
    ZXAddressModel *addressMoel = self.titleArray[indexPath.section][indexPath.row];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = addressMoel.listId;
    params[@"status"] = @2;
    [manager POST:Mine_DeleteAddress_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZXResponseObject
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DeliveryAddressController *vc = [[DeliveryAddressController alloc] init];
        vc.title = @"新增收货地址";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        DeliveryAddressController *vc = [[DeliveryAddressController alloc] init];
         ZXAddressModel *addressMoel = self.titleArray[indexPath.section][indexPath.row];
        vc.addressID = addressMoel.listId;
        vc.addressModel = addressMoel;
        vc.title = @"修改收货地址";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.titleArray = nil;
    self.view = nil;
}

@end
