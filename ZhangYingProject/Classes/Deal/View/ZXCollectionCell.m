//
//  ZXCollectionCell.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/29.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXCollectionCell.h"

#import "ZXCollectionModel.h"

NSString *const collectionCell = @"ZXCollectionCell";

@implementation ZXCollectionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    ZXCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXCollectionCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.borderWidth = 5;
    UIColor *color = RGB(216, 216, 216, 0.8);
    cell.layer.borderColor = [color CGColor];
    return cell;
}

-(void)setCollectionModel:(ZXCollectionModel *)collectionModel
{
    _collectionModel = collectionModel;
    self.productTitle.text = collectionModel.productTitle;
    self.commision.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"%@%%佣金",collectionModel.commision] Color:[UIColor redColor] FontSize:15];
//    ;
    self.earnings.text = [NSString stringWithFormat:@"%@%%",collectionModel.earnings];
//
    self.initialAmount.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"%@",collectionModel.initialAmount]  Color:[UIColor redColor] FontSize:15];
//
    self.productDeadlineName.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"%@",collectionModel.productDeadline]  Color:[UIColor redColor] FontSize:15];
//    ;
//    //产品类型名称
    self.productTypeName.text = collectionModel.typeName;
//
    self.salesStatusName.text = collectionModel.salesStatus;
//    //
    self.productAreaName.text = collectionModel.productField;
//    //
    self.productFieldName.text = collectionModel.productField;
}




@end
