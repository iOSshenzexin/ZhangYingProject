//
//  ZXCollectionCell.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/29.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXCollectionModel;
@interface ZXCollectionCell: UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,copy) ZXCollectionModel *collectionModel;

@property (weak, nonatomic) IBOutlet UILabel *productTitle;

@property (weak, nonatomic) IBOutlet UILabel *earnings;

@property (weak, nonatomic) IBOutlet UILabel *initialAmount;

@property (weak, nonatomic) IBOutlet UILabel *productDeadlineName;


@property (weak, nonatomic) IBOutlet UILabel *commision;

@property (weak, nonatomic) IBOutlet UILabel *productTypeName;

@property (weak, nonatomic) IBOutlet UILabel *productFieldName;

@property (weak, nonatomic) IBOutlet UILabel *productAreaName;

@property (weak, nonatomic) IBOutlet UILabel *salesStatusName;



@end
