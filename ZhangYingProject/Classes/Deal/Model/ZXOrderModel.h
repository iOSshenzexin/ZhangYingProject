//
//  ZXOrderModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXOrderModel : NSObject

/**
 {

 bankCard = "images/banner.jpg";
 cardnImage = "images/banner.jpg";
 cardpImage = "images/banner.jpg";
 certificateImage = "images/banner.jpg";

 createTime =                 {
 date = 12;
 day = 1;
 hours = 0;
 minutes = 0;
 month = 8;
 seconds = 0;
 time = 1473609600000;
 timezoneOffset = "-480";
 year = 116;
 };
 earnings = 7;
 endRow = 0;
 id = 5;
 investorAmount = "";
 makeId = 1;
 memberId = 12;
 orderNo = 20160808491815;
 pageIndex = 0;
 pageSize = 0;

 payAmounts = "";
 payTime = "<null>";


 productTerm = 1;

 startRow = 0;

 totalNum = 0;
 userName = "";
 },

 */

@property (nonatomic,copy) NSString *payAmount;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *payTimeStr;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *productTitle;


@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *bankCard;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *memberId;


@property (nonatomic,copy) NSString *cardNumber;
@property (nonatomic,copy) NSString *commission;
@property (nonatomic,copy) NSString *earnings;

@property (nonatomic,copy) NSString *orderNo;

@property (nonatomic,copy) NSString *cardnImage;
@property (nonatomic,copy) NSString *cardpImage;
@property (nonatomic,copy) NSString *certificateImage;





@end
