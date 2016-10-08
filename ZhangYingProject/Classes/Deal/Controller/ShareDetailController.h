//
//  ShareDetailController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareDetailController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *shareDetailTableView;

@property (nonatomic,copy) NSString *product_id;
@end
