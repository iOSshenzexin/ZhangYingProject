//
//  ProductDetailStyleTwoCustomCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXProuctDetailModel;
@interface ProductDetailStyleTwoCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbl1;

@property (weak, nonatomic) IBOutlet UILabel *lbl2;

@property (weak, nonatomic) IBOutlet UILabel *lbl3;


@property (weak, nonatomic) IBOutlet UILabel *lbl4;


@property (weak, nonatomic) IBOutlet UILabel *lbl5;

@property (weak, nonatomic) IBOutlet UILabel *lbl6;

@property (weak, nonatomic) IBOutlet UILabel *lbl7;


@property (weak, nonatomic) IBOutlet UILabel *lbl8;



@property (weak, nonatomic) IBOutlet UILabel *lbl9;

@property (weak, nonatomic) IBOutlet UILabel *commisionTypeNameLbl;

@property (nonatomic,copy) ZXProuctDetailModel *detailModel;



+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
