//
//  ZXEnterRecordModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZXEnterRecordModel : NSObject
/*
 data =     {
 datas =         (
 {
 amount = 10;
 createTime =                 {
 date = 21;
 day = 3;
 hours = 0;
 minutes = 0;
 month = 8;
 seconds = 0;
 time = 1474387200000;
 timezoneOffset = "-480";
 year = 116;
 };
 id = 2;
 memberId = 12;
 orderNo = 20160808491811;
 }
 );
 pageIndex = 0;
 pageOffset = 0;
 pageSize = 0;
 totalPage = 1;
 totalRecord = 2;
 };
 msg = "\U67e5\U8be2\U6210\U529f";
 status = 1;
 token = "";
 }

 */



@property (nonatomic,copy) NSString * orderNo;

@property (nonatomic,copy) NSDictionary *createTime;

@property (nonatomic,copy) NSString *amount;


@end
