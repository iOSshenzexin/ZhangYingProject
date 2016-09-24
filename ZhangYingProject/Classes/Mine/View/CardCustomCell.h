//
//  CardCustomCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXCardModel.h"
@interface CardCustomCell : UITableViewCell

@property (nonatomic,copy) ZXCardModel *cardModel;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *numberLbl;
@property (weak, nonatomic) IBOutlet UILabel *amountLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
