//
//  ZXMessageModel.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/24.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXMessageModel.h"

#import "MJExtension.h"
@implementation ZXMessageModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.message_id = value;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"message_id" : @"id"};
}

@end
