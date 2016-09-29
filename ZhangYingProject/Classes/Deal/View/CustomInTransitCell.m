//
//  CustomInTransitCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "CustomInTransitCell.h"

static NSString *customInTransitCell = @"CustomInTransitCell";

@implementation CustomInTransitCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 8;
    [super setFrame:frame];
}

+(instancetype)cellWithTableview:(UITableView *)tableview{
    CustomInTransitCell *cell = [tableview dequeueReusableCellWithIdentifier:customInTransitCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomInTransitCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setOrderModel:(ZXOrderModel *)orderModel
{
    _orderModel = orderModel;
    self.productTitle.text = orderModel.productTitle;
    self.userName.text = [NSString stringWithFormat:@"客户姓名: %@",orderModel.userName];
    self.account.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"打款金额: %@万元",orderModel.payAmount] Color:[UIColor redColor] FontSize:18];
    self.orderNumber.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"订单编号: %@",orderModel.orderNo] Color:[UIColor redColor] FontSize:14];
}
@end
