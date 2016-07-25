//
//  DeliveryAddressController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/25.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "DeliveryAddressController.h"
#import "DealCustomCell.h"
@interface DeliveryAddressController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *placeholderArray;
@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation DeliveryAddressController

-(NSArray *)placeholderArray{
    if (!_placeholderArray) {
        _placeholderArray = [NSArray arrayWithObjects:@"请输入联系人姓名",@"请输入联系人手机号码",@"请选择地区",@"请输入详细地址", nil];
    }
    return _placeholderArray;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"联系人姓名",@"联系人手机",@"省/市/区",@"详细地址", nil];
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.addressTableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    [self registerCell];
}

static NSString *cellID = @"cellId";
- (void)registerCell{
    UINib *nib = [UINib nibWithNibName:@"DealCustomCell" bundle:nil];
    [self.addressTableView registerNib:nib forCellReuseIdentifier:cellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DealCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DealCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    cell.layer.borderWidth = 1;
    //    UIColor *color = [UIColor blackColor];
    //    //RGB(242, 242, 242, 1);
    //    cell.layer.borderColor = [color CGColor];
    cell.txtField.placeholder = self.placeholderArray[indexPath.row];
    cell.lbl.text = self.titleArray[indexPath.row];
    return cell;
}




@end
