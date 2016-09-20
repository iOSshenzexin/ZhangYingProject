//
//  ZXTopic.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXTopic.h"

@implementation ZXTopic

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.product_id = value;
}

@end
