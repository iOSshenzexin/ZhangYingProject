//
//  MessageCustomCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/25.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXMessageModel;
@interface MessageCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,copy) ZXMessageModel *messageModel;
@end
