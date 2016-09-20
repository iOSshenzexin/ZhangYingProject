//
//  ZXProduct.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXProduct : NSObject
/**
 "productTitle": "中江信托-金鹤131号（第五期）", //产品标题
 "productType": 1, //产品类型Id
 "commision": 9,    //佣金（显示时后面加%）
 "earnings": 10,   //预计收益（显示时后面加%）
 "initialAmount": 100, //起始认购数（万元）
 "productTypeName": "信托类", //产品类型名称
 "salesStatusName": "售罄", //销售状态
 "productDeadlineName": "24个月", //产品期限
 "productFieldName": "政信类", //投资领域
 "productAreaName": "四川", //投资区域

 
 */

/** 产品Id */
@property (nonatomic,copy) NSString *productType;
/** 产品标题 */
@property (nonatomic,copy) NSString *productTitle;
/** 佣金（显示时后面加%） */
@property (nonatomic,copy) NSString *commision;
/** 预计收益（显示时后面加%） */
@property (nonatomic,copy) NSString *earnings;
/** 起始认购数（万元） */
@property (nonatomic,copy) NSString *initialAmount;

/** 销售状态 */
@property (nonatomic,copy) NSString *salesStatusName;
/** 产品类型名称 */
@property (nonatomic,copy) NSString *productTypeName;
/** 产品期限 */
@property (nonatomic,copy) NSString *productDeadlineName;
/** 投资领域 */
@property (nonatomic,copy) NSString *productFieldName;
/** 投资区域 */
@property (nonatomic,copy) NSString *productAreaName;



@end
