//
//  ZXSortModel.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/23.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXSortModel.h"

#import "MJExtension.h"
@implementation ZXSortModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.sortId = value;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"sortId" : @"id"};
}

@end
