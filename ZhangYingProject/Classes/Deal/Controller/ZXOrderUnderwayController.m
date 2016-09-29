//
//  ZXOrderUnderwayController.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXOrderUnderwayController.h"
#import "UIButton+WebCache.h"
@interface ZXOrderUnderwayController ()

@end

@implementation ZXOrderUnderwayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderNumberLbl.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"订单编号: %@",self.orderModel.orderNo] Color:[UIColor redColor] FontSize:15];
    
    self.productTitleLbl.text = self.orderModel.productTitle;
    self.userNameLbl.text = [NSString stringWithFormat:@"客户姓名: %@",self.orderModel.userName];
    self.identifierIdLbl.text = [NSString stringWithFormat:@"客户身份证号: %@",self.orderModel.cardNumber];
    self.payDateLbl.text = [NSString stringWithFormat:@"预计打款日期: %@",self.orderModel.payTimeStr];
    
    self.payAmountLbl.text = [NSString stringWithFormat:@"预计打款金额: %@万",self.orderModel.payAmount];
    
    self.telephoneLbl.text = [NSString stringWithFormat:@"联系方式: %.0f",[self.orderModel.phone doubleValue]];
    //
    self.addressLbl.text = [NSString stringWithFormat:@"收货地址: %@",self.orderModel.address];
    if ([self.orderModel.status intValue] == 1) {
        self.statusLbl.hidden = NO;
    }
    [self.card1 sd_setImageWithURL:[NSURL URLWithString:[baseUrl stringByAppendingString:[NSString stringWithFormat:@"/%@",self.orderModel.cardnImage]]] forState:UIControlStateNormal];
    [self.card2 sd_setImageWithURL:[NSURL URLWithString:[baseUrl stringByAppendingString:[NSString stringWithFormat:@"/%@",self.orderModel.cardpImage]]] forState:UIControlStateNormal];
    [self.card3 sd_setImageWithURL:[NSURL URLWithString:[baseUrl stringByAppendingString:[NSString stringWithFormat:@"/%@",self.orderModel.certificateImage]]] forState:UIControlStateNormal];
}

@end
