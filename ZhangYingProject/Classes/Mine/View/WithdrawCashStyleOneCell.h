//
//  WithdrawCashStyleOneCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawCashStyleOneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *withdrawAmount;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
