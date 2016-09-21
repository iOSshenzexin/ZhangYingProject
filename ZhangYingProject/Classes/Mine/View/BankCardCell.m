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
    cell.layer.borderWidth = 3;
    UIColor *color = RGB(242, 242, 242, 1);
    cell.layer.borderColor = [color CGColor];
    return cell;
}

-(void)setRecordModel:(ZXEnterRecordModel *)recordModel
{
    _recordModel = recordModel;
    self.timeLbl.text = recordModel.time;
    self.amountLbl.text = recordModel.amount;
    self.billNumber.text = recordModel.orderNo;
}

@end
