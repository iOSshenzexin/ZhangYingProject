//
//  ProductDetailStyleThreeCustomCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductDetailStyleThreeCustomCell.h"
#import "ZXProuctDetailModel.h"

@implementation ProductDetailStyleThreeCustomCell


NSString *const productDetailStyleThreeCustomCell = @"ProductDetailStyleThreeCustomCell";

-(void)setFrame:(CGRect)frame
{
    frame.size.height -=5;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    ProductDetailStyleThreeCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:productDetailStyleThreeCustomCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailStyleThreeCustomCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setDetailModel:(ZXProuctDetailModel *)detailModel
{
    _detailModel = detailModel;
    self.productAllTitleLbi.text = detailModel.productAllTitle;
    self.issuerNameLbl.text = detailModel.issuerName;
    self.salesAreaLbl.text = detailModel.salesArea;
    self.productFieldNameLbl.text = detailModel.productFieldName;
    self.raiseScaleLbl.text = detailModel.raiseScale;
    self.productDeadlineNameLbl.text = detailModel.productDeadlineName;
    self.initialAmountLbl.text =detailModel.initialAmount;
    self.payInterestNameLbl.text =detailModel.payInterestName;
}



@end
