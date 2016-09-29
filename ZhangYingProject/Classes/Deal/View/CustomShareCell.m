//
//  CustomShareCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "CustomShareCell.h"

@implementation CustomShareCell

static NSString *customShareCell= @"CustomShareCell";

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CustomShareCell *cell = [tableView dequeueReusableCellWithIdentifier:customShareCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomShareCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)setShareModel:(ZXShareModel *)shareModel{
    _shareModel = shareModel;
    self.typeLbl.text = shareModel.typeName;
    self.titleLbl.text = shareModel.productTitle;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    
    self.timeLbl.text = [NSString stringWithFormat:@"最后分享: %@",[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[shareModel.createTime[@"time"] doubleValue]/1000.0]]] ;
    
    
}


@end
