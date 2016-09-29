//
//  ZXAnnounceModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXAnnounceModel : NSObject
/*
 "id": 1,		//公告id
 "pid": 1,		//产品id
 "status": 1,
 "title": “标题”,
 "content":
 */


@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *pid;

@property (nonatomic,copy) NSString *announce_id;


@property (nonatomic,copy) NSDictionary *sTime;
@end
