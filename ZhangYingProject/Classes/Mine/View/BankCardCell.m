//
//  BankCardCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "BankCardCell.h"

#import "ZXEnterRecordModel.h"
@implementation BankCardCell

NSString *const cardCell = @"BankCardCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cardCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BankCardCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setRecordModel:(ZXEnterRecordModel *)recordModel
{
    _recordModel = recordModel;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *timeString = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[recordModel.createTime[@"time"] doubleValue]/1000.0]];
    self.timeLbl.text = timeString ;
    self.amountLbl.text = [NSString stringWithFormat:@"+%.2f",[recordModel.amount doubleValue]];
    self.billNumber.text = [NSString stringWithFormat:@"订单号:%@",recordModel.orderNo];
}

@end
