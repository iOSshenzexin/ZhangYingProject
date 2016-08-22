//
//  ProductReservationController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductReservationController.h"

#import "DeliveryAddressController.h"

@interface ProductReservationController ()

@end

@implementation ProductReservationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didClickChangeAddress:(id)sender {
    DeliveryAddressController *vc = [[DeliveryAddressController alloc] init];
    vc.title = @"修改收货地址";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
