//
//  ZXWithdrawCell.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXWithdrawRecordModel;

@interface ZXWithdrawCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bankNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *cardNumberLbl;

@property (weak, nonatomic) IBOutlet UILabel *acountLbl;

@property (weak, nonatomic) IBOutlet UILabel *applyTimeLbl;

@property (weak, nonatomic) IBOutlet UILabel *payTimeLbl;

@property (nonatomic,copy) ZXWithdrawRecordModel *withdrawRecordModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
