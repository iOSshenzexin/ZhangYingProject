//
//  DealTopCustomCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "DealTopCustomCell.h"

@implementation DealTopCustomCell

static NSString *dealTopCustomCell= @"DealTopCustomCell";

+ (instancetype)cellWithTableview:(UITableView *)tableview
{
    DealTopCustomCell *cell = [tableview dequeueReusableCellWithIdentifier:dealTopCustomCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DealTopCustomCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
