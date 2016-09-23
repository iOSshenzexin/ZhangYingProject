//
//  ZXSortModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/23.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXSortModel : NSObject
/**
 *  desc = "";
 id = 22;
 sort = 1;
 status = 1;
 title = "\U5c0f\U4e8e100\U4e07";
 type = 5;
 */

@property (nonatomic,copy) NSString *desc;

@property (nonatomic,copy) NSString *sortId;

@property (nonatomic,copy) NSString *sort;

@property (nonatomic,copy) NSString *status;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *type;





@end
