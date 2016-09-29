//
//  ZXShareModel.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXShareModel.h"

#import "MJExtension.h"

@implementation ZXShareModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.share_id = value;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"share_id" : @"id"};
}

@end
