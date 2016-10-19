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
#import "AddressCustomAddCell.h"
@interface AddAdressController ()<UITableViewDelegate,UITableViewDataSource,DeliveryAddressControllerDelegate>

@property (nonatomic,strong) NSMutableArray *titleArray;

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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadAdressData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return 60;
    return 85;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
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
            self.titleArray = [ZXAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)  return 1;
    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
      AddressCustomAddCell *cell = [AddressCustomAddCell cellWithTableView:tableView];
        return cell;
    }else{
        AddressCustomCell *cell = [AddressCustomCell cellWithTableView:tableView];
        cell.address = self.titleArray[indexPath.row];
         return cell;
    }
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
        [self.titleArray removeObjectAtIndex:indexPath.row];
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
    ZXAddressModel *addressMoel = self.titleArray[indexPath.row];
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
         ZXAddressModel *addressMoel = self.titleArray[indexPath.row];
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
