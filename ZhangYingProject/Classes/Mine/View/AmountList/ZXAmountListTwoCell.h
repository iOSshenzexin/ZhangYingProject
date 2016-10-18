//
//  ZXAmountListTwoCell.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXAccountInfoModel.h"

@interface ZXAmountListTwoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cardInfo;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UILabel *cardNumber;

@property (nonatomic,copy) ZXAccountInfoModel *accountModel;

@property (weak, nonatomic) IBOutlet UIImageView *defaultImage;

@property (weak, nonatomic) IBOutlet UIButton *updateBtn;

@end
