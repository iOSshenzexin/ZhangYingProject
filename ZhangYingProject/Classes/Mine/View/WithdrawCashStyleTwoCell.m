//
//  WithdrawCashStyleTwoCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "WithdrawCashStyleTwoCell.h"

static NSString *withdrawCashStyleTwoCell = @"WithdrawCashStyleTwoCell";
@implementation WithdrawCashStyleTwoCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -=3;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    WithdrawCashStyleTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:withdrawCashStyleTwoCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WithdrawCashStyleTwoCell class]) owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
