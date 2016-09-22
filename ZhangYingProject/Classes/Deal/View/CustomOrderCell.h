//
//  CustomOrderCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXReservationModel.h"
@interface CustomOrderCell : UITableViewCell

@property (nonatomic,copy) ZXReservationModel *reservationModel;

+ (instancetype)cellWithTableview:(UITableView *)tableview;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *accountLbl;

@end
