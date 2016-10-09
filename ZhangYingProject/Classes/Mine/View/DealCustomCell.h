//
//  DealCustomCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *txtField;
@property (nonatomic,strong) UILabel *lbl;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,copy) NSString *title;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
