//
//  ZXMessageModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/24.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXMessageModel : NSObject

/**
 *"id": 1,		//消息id
 "title": “标题”,
 "listImg": “”,		//列表图片地址
 "introduce": “内容简介”, 	//内容简介

 */

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *listImg;

@property (nonatomic,copy) NSString *introduce;

@property (nonatomic,copy) NSString *message_id;


@property (nonatomic,copy) NSDictionary *sTime;


@end
