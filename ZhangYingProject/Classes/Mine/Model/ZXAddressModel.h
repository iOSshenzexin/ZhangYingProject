//
//  ZXAddressModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXAddressModel : NSObject
/*
"status": 1,
"cityName": "青岛市",		//市
"provinceName": "山东省",		//省
"addressDetail": "123456789",	//详细地址
"id": 1,
"areaName": "崂山区",		//区
"userName": "liangyun",		//收货人姓名
"userPhone": "15264256235",	//收货人电话
"memberId": 2
 */

@property (nonatomic,copy) NSString *cityName;

@property (nonatomic,copy) NSString *provinceName;

@property (nonatomic,copy) NSString *areaName;

@property (nonatomic,copy) NSString *userName;

@property (nonatomic,copy) NSString *userPhone;

@property (nonatomic,copy) NSString *memberId;

@property (nonatomic,copy) NSString *listId;

@property (nonatomic,copy) NSString *isDefault;

@property (nonatomic,copy) NSString *status;

@end
