//
//  ZXReservationSuccessController.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXReservationSuccessController.h"

@interface ZXReservationSuccessController ()

@end

@implementation ZXReservationSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productTitle.text = self.reservationModel.proTitle;
    self.useName.text = [NSString stringWithFormat:@"客户姓名: %@",self.reservationModel.userName];
    self.memberId.text = [NSString stringWithFormat:@"客户身份证号: %@",self.reservationModel.memberId];
    self.payDate.text = [NSString stringWithFormat:@"预计打款日期: %@",self.reservationModel.payTimeStr];
    self.payAccount.text = [NSString stringWithFormat:@"预计打款金额: %@万",self.reservationModel.payAmount];
    
    self.telephone.text = [NSString stringWithFormat:@"联系方式: %@",self.reservationModel.phone];
    self.address.text = [NSString stringWithFormat:@"收货地址: %@",self.reservationModel.address];
}



@end
