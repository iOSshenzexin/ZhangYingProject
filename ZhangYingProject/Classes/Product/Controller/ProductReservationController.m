//
//  ProductReservationController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductReservationController.h"

#import "DeliveryAddressController.h"

@interface ProductReservationController (){
}

@end

@implementation ProductReservationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productNameLbl.text = [NSString stringWithFormat:@"  %@",self.productName];
    ZXLoginModel *model = AppLoginModel;
    self.phoneLbl.text = [NSString stringWithFormat:@"%.0f",model.phone];
}

- (IBAction)didClickChangeAddress:(id)sender {
    DeliveryAddressController *vc = [[DeliveryAddressController alloc] init];
    vc.title = @"修改收货地址";
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)didClickReservation:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"productId"] = self.product_id ;
    params[@"userName"] = self.nameTxt.text ;
    params[@"cardNumber"] = self.idTxt.text;
    params[@"payTimeStr"] = self.dateTxt.text;
    params[@"payAmount"] = self.accountTxt.text;
    params[@"phone"] = self.phoneLbl.text;
    params[@"address"] = self.addressLbl.text ;
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    
    ZXLog(@"params %@",params);
    [manager POST:Product_MakeReservation_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZXResponseObject
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}


@end
