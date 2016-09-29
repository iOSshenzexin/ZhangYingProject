//
//  CustomShareCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXShareModel.h"
@interface CustomShareCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;





@property (nonatomic,copy) ZXShareModel *shareModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
