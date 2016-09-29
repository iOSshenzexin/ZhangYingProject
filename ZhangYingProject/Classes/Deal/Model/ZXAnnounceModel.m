
//
//  ZXAnnounceModel.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXAnnounceModel.h"

#import "MJExtension.h"

@implementation ZXAnnounceModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.announce_id = value;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"announce_id" : @"id"};
}

@end
