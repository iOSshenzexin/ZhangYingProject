//
//  CustomInTransitCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXOrderModel.h"
@interface CustomInTransitCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *productTitle;

@property (weak, nonatomic) IBOutlet UILabel *userName;


@property (weak, nonatomic) IBOutlet UILabel *account;

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;




+(instancetype)cellWithTableview:(UITableView *)tableview;

@property (nonatomic,copy) ZXOrderModel *orderModel;

@end
