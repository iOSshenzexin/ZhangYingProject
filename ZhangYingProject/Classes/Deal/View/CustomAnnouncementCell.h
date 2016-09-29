//
//  CustomAnnouncementCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXAnnounceModel.h"

@interface CustomAnnouncementCell : UITableViewCell

@property (copy,nonatomic) ZXAnnounceModel *announceModel;

@property (weak, nonatomic) IBOutlet UILabel *subtitleLbl;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@end
