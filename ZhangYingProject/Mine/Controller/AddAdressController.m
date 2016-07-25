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
@interface AddAdressController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *imgArray;
@property (nonatomic,copy) NSMutableArray *titleArray;

@end

@implementation AddAdressController

  static NSString *str = @"cellId";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.addressTableVeiw.sectionFooterHeight = 15;
    self.addressTableVeiw.sectionHeaderHeight = 0;
    self.addressTableVeiw.rowHeight = 60;
    self.addressTableVeiw.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
    [self.addressTableVeiw registerNib:[UINib nibWithNibName:@"AddressCustomCell" bundle:nil] forCellReuseIdentifier:str];
    [self deleteBack];
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}

-(NSArray *)imgArray{
    if (!_imgArray) {
        _imgArray = [NSArray arrayWithObjects:@[@"my-trade03"],@[@"my-trade05"], nil];
    }
    return _imgArray;
}

-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@[@"新增收货地址"],[NSMutableArray arrayWithObjects:@"山东省青岛市崂山区苗岭路19号裕龙大厦2号楼2单元1302室",@"山东省青岛市崂山区苗岭路19号裕龙大厦2号楼2单元1302室",@"山东省青岛市崂山区苗岭路19号裕龙大厦2号楼2单元1302室",@"山东省青岛市崂山区苗岭路19号裕龙大厦2号楼2单元1302室", nil], nil];
    }
    return _titleArray;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return [self.titleArray[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[AddressCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIColor *color = RGB(242, 242, 242, 0.6);
    cell.layer.borderColor = [color CGColor];
    cell.layer.borderWidth = 2;
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.img.image = [UIImage imageNamed:self.imgArray[indexPath.section][indexPath.row]];
        cell.titleLabel.text = self.titleArray[indexPath.section][indexPath.row];
        cell.btn.hidden = YES;
        cell.titleLabel.textColor = [UIColor redColor];
    }else{
        cell.img.image = [UIImage imageNamed:self.imgArray[indexPath.section][0]];
        cell.titleLabel.text = self.titleArray[indexPath.section][indexPath.row];
        cell.titleLabel.numberOfLines = 0;
        [cell.btn addTarget:self action:@selector(modifyAddress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)modifyAddress:(UIButton *)btn{
    NSLog(@"xxxxxxx");
    DeliveryAddressController *vc = [[DeliveryAddressController alloc] init];
    vc.title = @"修改收货地址";
    [self.navigationController pushViewController:vc animated:YES];
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
        [self.titleArray[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.addressTableVeiw deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.addressTableVeiw reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DeliveryAddressController *vc = [[DeliveryAddressController alloc] init];
        vc.title = @"新增收货地址";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
    }
}



@end
