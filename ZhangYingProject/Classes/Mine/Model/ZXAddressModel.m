//
//  ZXAddressModel.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXAddressModel.h"
#import "MJExtension.h"
@implementation ZXAddressModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.listId = value;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"listId" : @"id"};
}

//- (NSString *)description
//{
//    return [NSString stringWithFormat:@"%@  %@  %@  %@ ,   %@   %@   %@" , self.cityName, self.provinceName,self.areaName,self.userName,self.userPhone,self.memberId ,self.listId];
//}
@end
