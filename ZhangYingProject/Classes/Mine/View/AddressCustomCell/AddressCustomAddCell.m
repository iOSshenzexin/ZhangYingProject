//
//  AddressCustomAddCell.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 2016/10/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "AddressCustomAddCell.h"

@implementation AddressCustomAddCell

static NSString *addressCustomAddCell = @"AddressCustomAddCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    AddressCustomAddCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCustomAddCell];
    if (cell == nil) {
      cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressCustomAddCell" owner:nil options:nil] lastObject];
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
