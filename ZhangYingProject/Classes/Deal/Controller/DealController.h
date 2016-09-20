//
//  DealController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *dealTableView;

@property (nonatomic,strong) UISegmentedControl *seg;

+(DealController *)sharedDealController;
@end
