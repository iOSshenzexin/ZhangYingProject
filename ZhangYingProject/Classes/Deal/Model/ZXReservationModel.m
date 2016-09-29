//
//  ZXReservationModel.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXReservationModel.h"

#import "MJExtension.h"

@implementation ZXReservationModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.reserver_id = value;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"reserver_id" : @"id"};
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXReservationModel *model = [[ZXReservationModel alloc]init];
    model.payAmount = self.payAmount;
    model.phone = self.phone;
    model.payTimeStr = self.payTimeStr;
    model.status = self.status;
    model.proTitle = self.proTitle;
    model.productId = self.productId;
    model.bankCard = self.bankCard;
    
    model.address = self.address;
    model.userName = self.userName;
    model.memberId = self.memberId;
    model.cardNumber = self.cardNumber;
    model.reserver_id = self.reserver_id;
    return model;
}
@end
