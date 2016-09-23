//
//  ProductDetailStyleOneCustomCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductDetailStyleOneCustomCell.h"
#import "ZXProuctDetailModel.h"
@implementation ProductDetailStyleOneCustomCell

NSString *const productDetailStyleOneCustomCell = @"ProductDetailStyleOneCustomCell";

-(void)setFrame:(CGRect)frame
{
    frame.size.height -=5;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    ProductDetailStyleOneCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:productDetailStyleOneCustomCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailStyleOneCustomCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setProductDetail:(ZXProuctDetailModel *)productDetail{
    _productDetail = productDetail;
    self.summaryLbl.text = productDetail.productDesc;
    CGFloat lblW = (ScreenW - 50) *0.25;
    CGFloat lblH = 20;
    for (NSInteger i = 0; i < productDetail.labelList.count; i ++) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10 + i % 4 *(lblW + 10), 5 + (i / 4) * (lblH + 5), lblW, lblH)];
        lbl.text = productDetail.labelList[i][@"labelName"];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:12];
        lbl.textColor = [UIColor redColor];
        lbl.backgroundColor = backGroundColor;
        [self.tagView addSubview:lbl];
    }
}
@end
