//
//  CustomPersonCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "CustomPersonCell.h"
static NSString *str = @"CustomPersonCell";
@implementation CustomPersonCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    CustomPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CustomPersonCell class]) owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
