//
//  ProductDetailStyleFourCustomCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXProuctDetailModel;
@interface ProductDetailStyleFourCustomCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *salesStatusNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *salesDescLbl;

@property (nonatomic,copy) ZXProuctDetailModel *detailModel;

@end
