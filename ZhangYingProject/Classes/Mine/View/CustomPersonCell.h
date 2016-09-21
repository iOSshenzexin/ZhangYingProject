//
//  CustomPersonCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPersonCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;



@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UITextField *txtField;

@property (weak, nonatomic) IBOutlet UIButton *changeNumberBtn;

@end
