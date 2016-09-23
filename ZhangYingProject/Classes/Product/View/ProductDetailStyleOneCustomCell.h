//
//  ProductDetailStyleOneCustomCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXProuctDetailModel;
@interface ProductDetailStyleOneCustomCell : UITableViewCell

@property (nonatomic,copy) ZXProuctDetailModel *productDetail;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UILabel *summaryLbl;
@property (weak, nonatomic) IBOutlet UIView *tagView;

@end
