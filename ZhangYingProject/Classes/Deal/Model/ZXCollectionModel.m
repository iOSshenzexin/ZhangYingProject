//
//  ZXCollectionModel.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/29.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXCollectionModel.h"

#import "MJExtension.h"

@implementation ZXCollectionModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.collection_id = value;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"collection_id" : @"id"};
}
@end
