//
//  ZXAmountListOneCell.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXAmountListOneCell.h"

@implementation ZXAmountListOneCell


NSString *const amountListOneCell = @"ZXAmountListOneCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    ZXAmountListOneCell *cell = [tableView dequeueReusableCellWithIdentifier:amountListOneCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXAmountListOneCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

@end
