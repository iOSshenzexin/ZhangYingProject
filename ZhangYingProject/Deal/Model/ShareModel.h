//
//  ShareModel.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/13.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject

@property (nonatomic,retain) NSArray *array;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,assign,getter = isOpened) BOOL opened;

@end
