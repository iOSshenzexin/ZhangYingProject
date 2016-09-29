//
//  WithdrawCashStyleThreeCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "WithdrawCashStyleThreeCell.h"

static NSString *withdrawCashStyleThreeCell = @"WithdrawCashStyleThreeCell";
@implementation WithdrawCashStyleThreeCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -=3;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    WithdrawCashStyleThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:withdrawCashStyleThreeCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WithdrawCashStyleThreeCell class]) owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
