//
//  ZXAccountInfoModel.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXAccountInfoModel.h"
#import "MJExtension.h"
@implementation ZXAccountInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.accountId = value;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"accountId" : @"id"};
}

@end
