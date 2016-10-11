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
    
    [self requestDefaultAddress];
    self.productNameLbl.text = [NSString stringWithFormat:@"  %@",self.productName];
    ZXLoginModel *model = AppLoginModel;
    self.phoneLbl.text = [NSString stringWithFormat:@"%.0f",model.phone];
    self.dateTxt.inputView = [self createUIDataPicker];
    
    [ZXNotificationCeter addObserver:self selector:@selector(changeDefaultAddress:) name:@"changAddress" object:nil];
}

- (void)changeDefaultAddress:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    self.nameTxt.text = dic[@"name"];
    
    self.phoneLbl.text = dic[@"phone"];
    
    self.addressLbl.text = dic[@"address"];
}

- (void)requestDefaultAddress
{
    ZXLoginModel *model = AppLoginModel;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"memberId"] = model.mid;
    [manager POST:Product_DefaultAddress_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responseObject[@"data"];
            
            if ([dic[@"status"] intValue] == 1) {
                self.addressLbl.text = [NSString stringWithFormat:@"%@%@%@%@",dic[@"provinceName"],dic[@"cityName"],dic[@"areaName"],dic[@"addressDetail"]];
            }
        }
        else{
            self.addressLbl.text = @"您还没有添加收货地址,可以点击修改添加!";
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}


- (UIDatePicker *)createUIDataPicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    // 本地化
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    // 日期控件格式
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(changed:) forControlEvents:UIControlEventValueChanged];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dateTxt.text = [formatter stringFromDate:[datePicker date]];
    return datePicker;
}

- (void)changed:(UIDatePicker *)datePicker{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dateTxt.text = [formatter stringFromDate:[datePicker date]];
}

- (IBAction)didClickChangeAddress:(id)sender {
    DeliveryAddressController *vc = [[DeliveryAddressController alloc] init];
    vc.title = @"修改收货地址";
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)didClickReservation:(id)sender {
    [MBProgressHUD showMessage:@"正在预约,请稍后...." toView:self.view];
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
    [manager POST:Product_MakeReservation_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([responseObject[@"status"] intValue] == 1) {
            [MBProgressHUD showSuccess:@"预约成功!"];
        }else{
            [MBProgressHUD showError:@"预约失败,请重试!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        ZXError
    }];
}


@end
