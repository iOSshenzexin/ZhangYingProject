//
//  ShareModel.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/13.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject
/*
 browseCount = 0;
 createTime =             {
 date = 29;
 day = 4;
 hours = 0;
 minutes = 0;
 month = 8;
 seconds = 0;
 time = 1475078400000;
 timezoneOffset = "-480";
 year = 116;
 };
 id = 50;
 memberId = 12;
 productId = 4;
 productTitle = "";
 typeName = "";
 
 
 */


@property (nonatomic,retain) NSArray * datas;

@property (nonatomic,copy) NSString *ymdTime;

@property (nonatomic,assign,getter = isOpened) BOOL opened;

@end
