//
//  ProductDetailStyleFourCustomCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductDetailStyleFourCustomCell.h"
#import "ZXProuctDetailModel.h"
NSString *const  productDetailStyleFourCustomCell= @"ProductDetailStyleFourCustomCell";

@implementation ProductDetailStyleFourCustomCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -=5;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    ProductDetailStyleFourCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:productDetailStyleFourCustomCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailStyleFourCustomCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setDetailModel:(ZXProuctDetailModel *)detailModel
{
    _detailModel = detailModel;
    self.salesStatusNameLbl.text = detailModel.salesStatusName;
    self.salesDescLbl.text = detailModel.salesDesc;
}
@end
