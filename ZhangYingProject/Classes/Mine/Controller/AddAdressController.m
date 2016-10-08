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
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titleArray = nil;
    [self loadAdressData];
}

#warning Today Done Here
- (void)setupTableView
{
    self.addressTableVeiw.sectionFooterHeight = 15;
    self.addressTableVeiw.dataSource = self;
    self.addressTableVeiw.delegate = self;
    self.addressTableVeiw.sectionHeaderHeight = 0;
    self.addressTableVeiw.rowHeight = 80;
    self.addressTableVeiw.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
}

- (void)loadAdressData
{
    NSArray *firstArray = [NSArray arrayWithObject:@"新增收货地址"];
    [self.titleArray addObject:firstArray];;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    params[@"pageIndex"] = @0;
    [manager POST:Mine_AddressList_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] intValue] == 1) {
            [self.titleArray addObject:[ZXAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]]];
            [self.addressTableVeiw reloadData];
            }
        else{
            [MBProgressHUD showError:@"请求失败!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误,请重试!"];
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
    if (indexPath.section == 0 && indexPath.row == 0) {
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
    //NSIndexPath * indexP =[NSIndexPath indexPathForRow:0 inSection:0];
   // if (indexP == indexPath) {
     //   return NO;
   // }
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.titleArray[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.addressTableVeiw deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.addressTableVeiw reloadData];
        [self deleteInternetAddressInfo:indexPath];
        
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
    AddressCustomCell *cell = [self.addressTableVeiw cellForRowAtIndexPath:indexPath];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = cell.address.listId;
    params[@"status"] = @2;
    ZXLog(@"删除: %@",params);
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
        AddressCustomCell *cell = [self.addressTableVeiw cellForRowAtIndexPath:indexPath];
        vc.addressID = cell.address.listId;
        vc.title = @"修改收货地址";
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
