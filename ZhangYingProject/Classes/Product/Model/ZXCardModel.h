//
//  ZXCardModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/24.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXCardModel : NSObject

/**
 *"startTime": { 		//有效开始时间
 "time": 1474214400000,
 },
 "id": 1,
 "cardNo": "234234234234", 	//卡券编号
 "minAmount": 200, 		//最小使用金额
 "cardAmount": 100, 		//卡券金额
 "status": 1,
 "memberId": 1, 			//用户Id
 "endTime": { 			//有效结束时间
 "time": 1474560000000,
 }

 */

@property (nonatomic,copy) NSDictionary *startTime;

@property (nonatomic,copy) NSDictionary *endTime;

@property (nonatomic,copy) NSString *cardNo;


@property (nonatomic,copy) NSString *minAmount;


@property (nonatomic,copy) NSString *cardAmount;



@end
