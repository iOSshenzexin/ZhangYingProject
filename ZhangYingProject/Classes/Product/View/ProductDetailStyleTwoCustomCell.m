//
//  ProductDetailStyleTwoCustomCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductDetailStyleTwoCustomCell.h"
#import "ZXProuctDetailModel.h"
@implementation ProductDetailStyleTwoCustomCell

NSString *const productDetailStyleTwoCustomCell = @"ProductDetailStyleTwoCustomCell";

-(void)setFrame:(CGRect)frame
{
    frame.size.height -=5;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    ProductDetailStyleTwoCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:productDetailStyleTwoCustomCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailStyleTwoCustomCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setDetailModel:(ZXProuctDetailModel *)detailModel
{
    _detailModel = detailModel;
    
    self.commisionTypeNameLbl.text = detailModel.commisionTypeName;
    if ([detailModel.commList count] == 1) {
        self.lbl1.text = [NSString stringWithFormat:@"%@-%@万",detailModel.commList[0][@"minAmount"],detailModel.commList[0][@"maxAmount"]];
        self.lbl2.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[0][@"earnings"] floatValue]];
        self.lbl3.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[0][@"commision"] floatValue]];
    }
    if ([detailModel.commList count] == 2) {
        self.lbl1.text = [NSString stringWithFormat:@"%@-%@万",detailModel.commList[0][@"minAmount"],detailModel.commList[0][@"maxAmount"]];
        self.lbl2.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[0][@"earnings"] floatValue]];
        self.lbl3.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[0][@"commision"] floatValue]];
        self.lbl4.text = [NSString stringWithFormat:@"%@-%@万",detailModel.commList[1][@"minAmount"],detailModel.commList[1][@"maxAmount"]];
        self.lbl5.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[1][@"earnings"] floatValue]];
        self.lbl6.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[1][@"commision"] floatValue]];

    }
    if ([detailModel.commList count] == 3) {
        self.lbl1.text = [NSString stringWithFormat:@"%@-%@万",detailModel.commList[0][@"minAmount"],detailModel.commList[0][@"maxAmount"]];
        self.lbl2.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[0][@"earnings"] floatValue]];
        self.lbl3.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[0][@"commision"] floatValue]];
        self.lbl4.text = [NSString stringWithFormat:@"%@-%@万",detailModel.commList[1][@"minAmount"],detailModel.commList[1][@"maxAmount"]];
        self.lbl5.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[1][@"earnings"] floatValue]];
        self.lbl6.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[1][@"commision"] floatValue]];
        self.lbl7.text = [NSString stringWithFormat:@"%@-%@万",detailModel.commList[2][@"minAmount"],detailModel.commList[2][@"maxAmount"]];
         self.lbl8.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[2][@"earnings"] floatValue]];
         self.lbl9.text = [NSString stringWithFormat:@"%.2f%%",[detailModel.commList[2][@"commision"] floatValue]];
    }

}
@end
