//
//  DealController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "DealController.h"

#import "DealTopCustomCell.h"

#import "MyReservationController.h"
@interface DealController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation DealController

static NSString *cellId = @"cell";

static NSString *defaultCell = @"defaultCell";

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"我的预约",@"我的订单",@"产品需求",@"产品公告", nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dealTableView registerNib:[UINib nibWithNibName:@"DealTopCustomCell" bundle:nil] forCellReuseIdentifier:cellId];
    //self.dealTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero]6
    self.dealTableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    self.dealTableView.sectionFooterHeight = 20;
    self.dealTableView.sectionHeaderHeight = 0;
    [self deleteBack];
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==1) return 4;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DealTopCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[DealTopCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCell];
     if (!cell) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCell];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.titleArray[indexPath.row];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                MyReservationController *vc = [[MyReservationController alloc] init];
                vc.title = @"我的预约";
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            }
                
                break;
                
            default:
                break;
        }
    }}


@end
