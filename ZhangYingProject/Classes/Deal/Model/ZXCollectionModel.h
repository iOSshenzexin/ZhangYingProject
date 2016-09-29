//
//  ZXCollectionModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/29.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXCollectionModel : NSObject

/*
 commision = "9.00";
 createTime =                 {
 date = 28;
 day = 3;
 hours = 0;
 minutes = 0;
 month = 8;
 seconds = 0;
 time = 1474992000000;
 timezoneOffset = "-480";
 year = 116;
 };
 earnings = "10.00";
 endRow = 0;
 id = 32;
 initialAmount = "小于100万";
 memberId = 12;
 pageIndex = 0;
 pageSize = 0;
 proStatus = 1;
 productDeadline = "<12个月";
 productField = "政信类";
 productId = 11;
 productTitle = "中江信托-金鹤141号（第五期）";
 salesStatus = "开放募集";
 startRow = 0;
 status = 1;
 totalNum = 0;
 typeName = "资管";
 },
 
 */

@property (nonatomic,copy) NSString * commision;

@property (nonatomic,copy) NSString * createTime;

@property (nonatomic,copy) NSString * earnings;

@property (nonatomic,copy) NSString * initialAmount;

@property (nonatomic,copy) NSString * productDeadline;

@property (nonatomic,copy) NSString * productField;

@property (nonatomic,copy) NSString * productTitle;

@property (nonatomic,copy) NSString * salesStatus;

@property (nonatomic,copy) NSString * typeName;


@property (nonatomic,copy) NSString * productId;

@property (nonatomic,copy) NSString * collection_id;

@end
