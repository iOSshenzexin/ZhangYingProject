//
//  AddressCustomCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/25.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "AddressCustomCell.h"
#import "ZXAddressModel.h"
static NSString *addressCustomCell = @"AddressCustomCell";

@implementation AddressCustomCell

-(void)setFrame:(CGRect)frame
{
    frame.size.height -=5;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    //AddressCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCustomCell];
    //if (cell == nil) {
    AddressCustomCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressCustomCell" owner:nil options:nil] lastObject];
    //}
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   // UIColor *color = RGB(242, 242, 242, 0.6);
    //cell.layer.borderColor = [color CGColor];
    //cell.layer.borderWidth = 2;
    return cell;
}

-(void)setAddress:(ZXAddressModel *)address{
    _address = address;
    self.phoneLbl.text = address.userPhone;
    self.nameLbl.text = address.userName;
    self.titleLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",address.provinceName,address.cityName,address.areaName,address.addressDetail];
    if ([address.isDefault intValue] == 1) {
        self.defaultImage.hidden = NO;
    }
}
@end
