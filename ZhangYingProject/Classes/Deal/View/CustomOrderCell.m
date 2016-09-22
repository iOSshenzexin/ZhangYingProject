//
//  CustomOrderCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "CustomOrderCell.h"

static NSString *customOrderCell= @"CustomOrderCell";

@implementation CustomOrderCell

+(instancetype)cellWithTableview:(UITableView *)tableview{
    CustomOrderCell *cell = [tableview dequeueReusableCellWithIdentifier:customOrderCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomOrderCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.borderWidth = 3;
    UIColor *color = RGB(242, 242, 242, 1);
    cell.layer.borderColor = [color CGColor];
    return cell;
}

-(void)setReservationModel:(ZXReservationModel *)reservationModel
{
    _reservationModel = reservationModel;
    self.titleLbl.text = reservationModel.proTitle;
    
    self.nameLbl.text = [NSString stringWithFormat:@"客户姓名: %@",reservationModel.userName];
    
    self.accountLbl.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"打款金额: %d万元",[reservationModel.payAmount intValue]] Color:[UIColor redColor] FontSize:20];
}
@end
