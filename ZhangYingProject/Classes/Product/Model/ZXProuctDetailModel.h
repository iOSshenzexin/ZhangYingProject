//
//  ZXProuctDetailModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/23.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXProuctDetailModel : NSObject

/*
 
 commList =         (
 {
 commision = 10;
 earnings = 10;
 id = 1;
 maxAmount = 100;
 minAmount = 0;
 productId = 1;
 status = 1;
 },
 {
 commision = 9;
 earnings = 10;
 id = 2;
 maxAmount = 200;
 minAmount = 100;
 productId = 1;
 status = 1;
 },
 {
 commision = 9;
 earnings = 10;
 id = 3;
 maxAmount = 0;
 minAmount = 200;
 productId = 1;
 status = 1;
 }
 );
 commision = 9;
 commisionType = 31;
 commisionTypeName = "";
 createTime = "<null>";
 earmarking = "\U4e2d\U6c5f\U4fe1\U6258-\U91d1\U9e64131\U53f7\Uff08\U7b2c\U4e94\U671f\Uff09";
 earnings = 10;
 enclosure = "\U4e2d\U6c5f\U4fe1\U6258-\U91d1\U9e64131\U53f7\Uff08\U7b2c\U4e94\U671f\Uff09";
 endRow = 0;
 financing = "\U963f\U65af\U8fbe\U662f\U7684";
 initialAmount = 22;
 initialAmountName = "";
 isCollection = 0;
 isControll = 1;
 isRecommend = 1;
 issuer = 18;
 issuerName = "";
 labelId =         (
 );
 labelList =         (
 {
 id = 20;
 labelId = 30;
 labelName = "\U4e00\U5e74\U671f";
 productId = 1;
 status = 1;
 },
 {
 id = 19;
 labelId = 9;
 labelName = "\U534a\U5e74\U4ed8\U606f";
 productId = 1;
 status = 1;
 },
 {
 id = 18;
 labelId = 8;
 labelName = "2\U5e74\U671f";
 productId = 1;
 status = 1;
 },
 {
 id = 17;
 labelId = 7;
 labelName = "AA\U4e3b\U4f53";
 productId = 1;
 status = 1;
 },
 {
 id = 16;
 labelId = 6;
 labelName = "\U5de5\U5546\U4f01\U4e1a\U7c7b";
 productId = 1;
 status = 1;
 }
 );
 measures = "\U4e2d\U6c5f\U4fe1\U6258-\U91d1\U9e64131\U53f7\Uff08\U7b2c\U4e94\U671f\Uff09";
 pageIndex = 0;
 pageSize = 0;
 payInterest = 26;
 payInterestName = "";
 payment = "\U4e2d\U6c5f\U4fe1\U6258-\U91d1\U9e64131\U53f7\Uff08\U7b2c\U4e94\U671f\Uff09";
 proId = 1;
 productAllTitle = "\U4e2d\U6c5f\U4fe1\U6258-\U91d1\U9e64131\U53f7\Uff08\U7b2c\U4e94\U671f\Uff09";
 productDeadline = 1;
 productDeadlineName = "<12\U4e2a\U6708";
 productDesc = "\U4e2d\U6c5f\U4fe1\U6258-\U91d1\U9e64131\U53f7\Uff08\U7b2c\U4e94\U671f\Uff09";
 productField = 14;
 productFieldName = "";
 productTitle = "\U4e2d\U6c5f\U4fe1\U6258-\U91d1\U9e64131\U53f7\Uff08\U7b2c\U4e94\U671f\Uff09";
 productType = 1;
 productTypeName = "\U4fe1\U6258";
 project = "\U4e2d\U6c5f\U4fe1\U6258-\U91d1\U9e64131\U53f7\Uff08\U7b2c\U4e94\U671f\Uff09";
 raiseAccount = "\U4e2d\U6c5f\U4fe1\U6258-\U91d1\U9e64131\U53f7\Uff08\U7b2c\U4e94\U671f\Uff09";
 raiseScale = "15\U4ebf";
 salesArea = "\U5317\U4eac\U5e02";
 salesDesc = "\U7b2c\U4e94\U671f\U5f00\U653e\U642d\U6b3e\U4e2d";
 salesStatus = 11;
 salesStatusName = "\U5f00\U653e\U52df\U96c6";
 sellers = "\U91d1\U7ecf\U7406";
 sort = 0;
 startRow = 0;
 status = 0;
 totalNum = 0;
 updateTime =         {
 date = 7;
 day = 3;
 hours = 16;
 minutes = 54;
 month = 8;
 seconds = 38;
 time = 1473238478000;
 timezoneOffset = "-480";
 year = 116;
 };
 };
 msg = "\U67e5\U8be2\U6210\U529f";
 status = 1;
 token = "";
 }
 */

@property (nonatomic,copy) NSArray *commList;

@property (nonatomic,copy) NSString *createTime;

@property (nonatomic,copy) NSString *productDeadlineName;

@property (nonatomic,copy) NSString *earmarking;

@property (nonatomic,copy) NSArray *labelList;

@property (nonatomic,copy) NSString *productType;

@property (nonatomic,copy) NSString *commision;

@property (nonatomic,copy) NSString *salesDesc;

@property (nonatomic,copy) NSString *financing;

@property (nonatomic,copy) NSString *commisionTypeName;

@property (nonatomic,copy) NSString *productTypeName;

/*
 "payInterestName": "订单完成时结算", 	//付息方式
 "earnings": 10, 		//预计收益（显示时后面加%）
 "proId": 1, 		//产品Id
 "enclosure": "中江信托-金鹤131号（第五期）", //产品附件
 "payment": "中江信托-金鹤131号（第五期）", //还款来源
 "status": "1", //产品状态
 "productAllTitle": "中江信托-金鹤131号（第五期）", //产品总标题
 
 */

@property (nonatomic,copy) NSString *payInterestName;

@property (nonatomic,copy) NSString *earnings;

@property (nonatomic,copy) NSString *proId;

@property (nonatomic,copy) NSString *enclosure;

@property (nonatomic,copy) NSString *payment;

@property (nonatomic,copy) NSString *status;

@property (nonatomic,copy) NSString *productAllTitle;

/**
 "raiseAccount": "中江信托-金鹤131号（第五期）", //筹集账号
 "initialAmountName": "", 	//起投金额
 "project": "中江信托-金鹤131号（第五期）", 	//项目亮点
 "productDesc": "中江信托-金鹤131号（第五期）", //产品简介
 "productFieldName": "", 	//投资领域
 "productTitle": "中江信托-金鹤131号（第五期）", //产品标题(简称)
 "issuerName": "", 		//发行方
 "measures": "中江信托-金鹤131号（第五期）", //风控措施
 "salesStatusName": "售罄"	//销售状态
 */

@property (nonatomic,copy) NSString *raiseAccount;

@property (nonatomic,copy) NSString *initialAmountName;

@property (nonatomic,copy) NSString *project;

@property (nonatomic,copy) NSString *productDesc;

@property (nonatomic,copy) NSString *productFieldName;

@property (nonatomic,copy) NSString *productTitle;

@property (nonatomic,copy) NSString *issuerName;

@property (nonatomic,copy) NSString *measures;

@property (nonatomic,copy) NSString *salesStatusName;


@property (nonatomic,copy) NSString *raiseScale;

@property (nonatomic,copy) NSString *salesArea;

@property (nonatomic,copy) NSString *initialAmount;

@end
