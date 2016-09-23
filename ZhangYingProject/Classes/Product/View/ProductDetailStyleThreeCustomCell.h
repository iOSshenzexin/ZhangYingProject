//
//  ProductDetailStyleThreeCustomCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXProuctDetailModel;

@interface ProductDetailStyleThreeCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productAllTitleLbi;

@property (weak, nonatomic) IBOutlet UILabel *issuerNameLbl;


@property (weak, nonatomic) IBOutlet UILabel *salesAreaLbl;

@property (weak, nonatomic) IBOutlet UILabel *productFieldNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *raiseScaleLbl;

@property (weak, nonatomic) IBOutlet UILabel *productDeadlineNameLbl;


@property (weak, nonatomic) IBOutlet UILabel *initialAmountLbl;


@property (weak, nonatomic) IBOutlet UILabel *payInterestNameLbl;







+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,copy) ZXProuctDetailModel *detailModel;

@end
