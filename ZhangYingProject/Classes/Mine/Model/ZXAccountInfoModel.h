//
//  ZXAccountInfoModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXAccountInfoModel : NSObject
/*
 accountName = 123;
 bankBranch = 123;
 bankCard = 123;
 bankName = 123;
 createTime =             {
 date = 22;
 day = 4;
 hours = 0;
 minutes = 0;
 month = 8;
 seconds = 0;
 time = 1474473600000;
 timezoneOffset = "-480";
 year = 116;
 };
 id = 4;
 
 */

@property (nonatomic,copy) NSString * accountName;

@property (nonatomic,copy) NSDictionary *bankBranch;

@property (nonatomic,copy) NSString *bankCard;

@property (nonatomic,copy) NSString *bankName;

@property (nonatomic,copy) NSDictionary *createTime;

@property (nonatomic,copy) NSString *accountId;

@property (nonatomic,copy) NSString *isDefault;




@end
