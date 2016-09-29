//
//  ZXShareModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXShareModel : NSObject
/*
"typeName": "信托", 			//产品类型
"id": 0,
"createTime": { 			//最后分享时间
    "time": 1474443086000,
    "minutes": 31,
    "seconds": 26,
    "hours": 15,
    "month": 8,
    "year": 116,
    "timezoneOffset": -480,
    "day": 3,
    "date": 21
},
"browseCount": 0, //
"productTitle": "中江信托-金鹤131号（第五期）", //产品标题
"memberId": 0,
"productId": 1
 */

@property (nonatomic,copy) NSString *typeName;

@property (nonatomic,copy) NSString *productTitle;

@property (nonatomic,copy) NSDictionary *createTime;

@property (nonatomic,copy) NSString *productId;

@property (nonatomic,copy) NSString *share_id;

@end
