//
//  ProductShareController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductShareController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *productShareTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic,copy) NSString *productTitle;
@property (nonatomic,copy) NSString *product_id;

@end
