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
    UIColor *color = RGB(242, 242, 242, 1);
    cell.layer.borderColor = [color CGColor];
    return cell;
}

-(void)setProduct:(ZXProduct *)product
{
    _product = product;
    self.productTitle.text = product.productTitle;
    self.commision.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"%@%%佣金",product.commision] Color:[UIColor redColor] FontSize:16];
    ;
    self.earnings.text = [NSString stringWithFormat:@"%.2f%%",[product.earnings floatValue]];
    
    self.initialAmount.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"%@万起",product.initialAmount]  Color:[UIColor blackColor] FontSize:16];
    
    self.productDeadlineName.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"%@",product.productDeadlineName]  Color:[UIColor blackColor] FontSize:16];
    ;
    //产品类型名称
    self.productTypeName.text = product.productTypeName;
    
    self.salesStatusName.text = product.salesStatusName;
//
    self.productAreaName.text = product.salesArea;
//
    self.productFieldName.text = product.productFieldName;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
