//
//  SecuritySetController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "SecuritySetController.h"

#import "ChangeLoginNumberController.h"
#import "ChangePhoneController.h"
@interface SecuritySetController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *imgArray;
@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation SecuritySetController

-(NSArray *)imgArray{
    if (!_imgArray) {
        _imgArray = [NSArray arrayWithObjects:@"my-trade06",@"my-trade07", nil];
    }
    return _imgArray;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"修改登录密码",@"更换绑定手机", nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.securityTableView.sectionFooterHeight = 0;
    self.securityTableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.securityTableView.sectionHeaderHeight = 10;
    self.securityTableView.tableHeaderView = 0;
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
    cell.imageView.image = [UIImage imageNamed:self.imgArray[indexPath.section]];
    cell.textLabel.text = self.titleArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            self.hidesBottomBarWhenPushed = YES;
            ChangeLoginNumberController *vc = [[ChangeLoginNumberController alloc] init];
            vc.title = @"修改登录密码";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            self.hidesBottomBarWhenPushed = YES;
            ChangePhoneController *vc = [[ChangePhoneController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            vc.title = @"更换绑定手机";
            [self.navigationController pushViewController:vc animated:YES];        }
            break;
        default:
            break;
    }
}

@end
