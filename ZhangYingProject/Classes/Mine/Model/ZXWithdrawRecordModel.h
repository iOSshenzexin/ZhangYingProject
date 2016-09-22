//
//  ZXWithdrawRecordModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXWithdrawRecordModel : NSObject

@property (nonatomic,copy) NSString * bankName;

//申请时间
@property (nonatomic,copy) NSDictionary *createTime;

//打款时间
@property (nonatomic,copy) NSDictionary *payTime;

@property (nonatomic,copy) NSString *bankCard;

@property (nonatomic,copy) NSString *amount;
@end
