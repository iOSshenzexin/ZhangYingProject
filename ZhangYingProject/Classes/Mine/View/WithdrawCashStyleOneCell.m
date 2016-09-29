//
//  WithdrawCashStyleOneCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "WithdrawCashStyleOneCell.h"

static NSString *str = @"WithdrawCashStyleOneCell";
@implementation WithdrawCashStyleOneCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -=3;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    WithdrawCashStyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WithdrawCashStyleOneCell class]) owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
