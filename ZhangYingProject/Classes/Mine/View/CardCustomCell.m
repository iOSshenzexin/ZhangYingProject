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
    self.priceLbl.text = cardModel.cardAmount;
    self.numberLbl.text = cardModel.cardNo;
    self.amountLbl.text = cardModel.minAmount;
    self.timeLbl.text = cardModel.endTime[@"time"];
    
}

@end
