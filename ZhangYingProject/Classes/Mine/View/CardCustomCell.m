//
//  CardCustomCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "CardCustomCell.h"

NSString *const cardCustomCell = @"CardCustomCell";
@implementation CardCustomCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -=5;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    CardCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cardCustomCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CardCustomCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setCardModel:(ZXCardModel *)cardModel
{
    _cardModel = cardModel;
    self.priceLbl.text = [NSString stringWithFormat:@"¥%@",cardModel.cardAmount];
    self.numberLbl.text = [NSString stringWithFormat:@"券编号:%@",cardModel.cardNo];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
     NSString *startTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[cardModel.startTime[@"time"] doubleValue]/1000.0]];
    NSString *endTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[cardModel.endTime[@"time"] doubleValue]/1000.0]];
    
    self.amountLbl.text = [NSString stringWithFormat:@"认购金额%@万起可用",cardModel.minAmount];
    
//    
    self.timeLbl.text = [NSString stringWithFormat:@"%@至%@",startTime,endTime];
}

@end
