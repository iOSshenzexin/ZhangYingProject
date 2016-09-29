//
//  ProductShareCustomSyleOneCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductShareCustomSyleOneCell.h"

NSString *const productShareCustomSyleOneCell = @"ProductShareCustomSyleOneCell";
@implementation ProductShareCustomSyleOneCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    ProductShareCustomSyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:productShareCustomSyleOneCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductShareCustomSyleOneCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
