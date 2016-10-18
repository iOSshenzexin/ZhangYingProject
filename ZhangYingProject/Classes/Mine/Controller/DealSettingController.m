//
//  DealSettingController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "DealSettingController.h"
#import "ZXCommissionListController.h"
#import "AddAdressController.h"
@interface DealSettingController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *imgArray;
@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation DealSettingController

-(NSArray *)imgArray{
    if (!_imgArray) {
        _imgArray = [NSArray arrayWithObjects:@"my-trade01",@"my-trade02", nil];
    }
    return _imgArray;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"添加结佣账户",@"添加收货地址", nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dealTableView.sectionFooterHeight = 0;
    self.dealTableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.dealTableView.sectionHeaderHeight = 10;
    self.dealTableView.tableHeaderView = 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.layer.borderWidth = 1;
    UIColor *color = RGB(216, 216, 216, 0.8);
    cell.layer.borderColor = [color CGColor];
    
    cell.imageView.image = [UIImage imageNamed:self.imgArray[indexPath.section]];
    cell.textLabel.text = self.titleArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            ZXCommissionListController *vc = [[ZXCommissionListController alloc] init];
            vc.title = @"添加结佣账户";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:{
            AddAdressController *vc = [[AddAdressController alloc] init];
            vc.title = @"添加收货地址";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}


@end
