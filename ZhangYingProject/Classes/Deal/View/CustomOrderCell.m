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
-(void)setFrame:(CGRect)frame
{
    frame.size.height -=5;
    [super setFrame:frame];
}

+(instancetype)cellWithTableview:(UITableView *)tableview{
    CustomOrderCell *cell = [tableview dequeueReusableCellWithIdentifier:customOrderCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomOrderCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
