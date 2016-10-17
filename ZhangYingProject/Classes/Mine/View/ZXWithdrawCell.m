//
//  ZXWithdrawCell.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXWithdrawCell.h"

#import "ZXWithdrawRecordModel.h"

NSString *const withdrawCell = @"ZXWithdrawCell";

@implementation ZXWithdrawCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -=4;
    [super setFrame: frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    ZXWithdrawCell *cell = [tableView dequeueReusableCellWithIdentifier:withdrawCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXWithdrawCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setWithdrawRecordModel:(ZXWithdrawRecordModel *)withdrawRecordModel{
    _withdrawRecordModel = withdrawRecordModel;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
   
    self.applyTimeLbl.text =[NSString stringWithFormat:@"申请时间: %@",[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[withdrawRecordModel.createTime[@"time"] doubleValue]/1000.0]]] ;
  
    if ([withdrawRecordModel.payTime[@"time"] doubleValue] == 0.000000 ) {
        self.payTimeLbl.text = @"尚未打款";
        self.payTimeLbl.textColor = [UIColor redColor];
    }else{
        self.payTimeLbl.textColor = RGB(154, 154, 154, 1);
        self.payTimeLbl.text = [NSString stringWithFormat:@"打款时间: %@",[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[withdrawRecordModel.payTime[@"time"] doubleValue]/1000.0]]];
    }
    self.bankNameLbl.text = withdrawRecordModel.bankName;
    self.cardNumberLbl.text = withdrawRecordModel.bankCard;
    self.acountLbl.text = [NSString stringWithFormat:@"+%.2f",[withdrawRecordModel.amount doubleValue]];
}
@end
