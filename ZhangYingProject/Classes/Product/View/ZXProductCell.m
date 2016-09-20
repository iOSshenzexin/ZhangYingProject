//
//  ZXProductCell.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXProductCell.h"

#import "ZXProduct.h"
NSString *const cellId = @"ZXProductCell";

@implementation ZXProductCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    ZXProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXProductCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.borderWidth = 5;
    UIColor *color = RGB(216, 216, 216, 0.8);
    cell.layer.borderColor = [color CGColor];
    return cell;
}

/**
 "productTitle": "中江信托-金鹤131号（第五期）", //产品标题
 "productType": 1, //产品类型Id
 "commision": 9,    //佣金（显示时后面加%）
 "earnings": 10,   //预计收益（显示时后面加%）
 "initialAmount": 100, //起始认购数（万元）
 "productTypeName": "信托类", //产品类型名称
 "salesStatusName": "售罄", //销售状态
 "productDeadlineName": "24个月", //产品期限
 "productFieldName": "政信类", //投资领域
 "productAreaName": "四川", //投资区域
 
 */
-(void)setProduct:(ZXProduct *)product
{
    _product = product;
    self.productTitle.text = product.productTitle;
    self.commision.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"%@%%佣金",product.commision] Color:[UIColor redColor] FontSize:18];
    ;
    self.earnings.text = [NSString stringWithFormat:@"%.2f%%",[product.earnings floatValue]];
    
    self.initialAmount.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"%@万起",product.initialAmount]  Color:[UIColor blackColor] FontSize:18];
    
    self.productDeadlineName.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"%@",product.productDeadlineName]  Color:[UIColor blackColor] FontSize:18];
    ;
    self.productTypeName.text = product.productTypeName;
    
    self.salesStatusName.text = product.salesStatusName;
    
    self.productAreaName.text = product.productAreaName;
    self.productFieldName.text = product.productFieldName;
}

@end
