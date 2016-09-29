

//
//  ZXReservationFailureController.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXReservationFailureController.h"

@interface ZXReservationFailureController ()

@end

@implementation ZXReservationFailureController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZXLog(@"reserver_id : %@",self.reservationModel.reserver_id);
    [self requestReseverationDetailInfomation];
}

- (void)requestReseverationDetailInfomation
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mid"] = self.reservationModel.reserver_id;
    [mgr POST:Deal_ReservationDetail_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        self.productTitleLbl.text = dic[@"proTitle"];
        self.userNameLbl.text = [NSString stringWithFormat:@"客户姓名: %@",dic[@"userName"]];
        self.identifierIdLbl.text = [NSString stringWithFormat:@"客户身份证号: %@",dic[@"cardNumber"]];
        
        self.payDateLbl.text = [NSString stringWithFormat:@"预计打款日期: %@",dic[@"payTimeStr"]];
        self.payAmountLbl.text = [NSString stringWithFormat:@"预计打款金额: %@万",dic[@"payAmount"]];
        
        self.telephoneLbl.text = [NSString stringWithFormat:@"联系方式: %.0f",[dic[@"phone"] doubleValue]];
        
        self.addressLbl.text = [NSString stringWithFormat:@"收货地址: %@",dic[@"address"]];
        if ([dic[@"status"] intValue] == 3) {
            self.statusLbl.hidden = NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}

@end
