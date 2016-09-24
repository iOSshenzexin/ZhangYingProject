//
//  MessageCustomCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/25.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MessageCustomCell.h"

#import "ZXMessageModel.h"
@implementation MessageCustomCell

NSString *const messageCustomCell = @"MessageCustomCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    MessageCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCustomCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageCustomCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIColor *color = RGB(242, 242, 242, 1);
    cell.layer.borderColor = [color CGColor];
    cell.layer.borderWidth = 2;
    return cell;
}

/**
 *" conImg = "";
 content = "";
 id = 10;
 introduce = mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm;
 listImg = "E:\\workspace_camelot\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\palmWin\\jpg1474688124262.jpeg";
 sTime =             {
 date = 24;
 day = 6;
 hours = 0;
 minutes = 0;
 month = 8;
 seconds = 0;
 time = 1474646400000;
 timezoneOffset = "-480";
 year = 116;
 };
 title = mmmmmmmmmmmmmmmmmm;
  */

-(void)setMessageModel:(ZXMessageModel *)messageModel
{
    _messageModel = messageModel;
    self.titleLbl.text = messageModel.title;
    self.subTitleLbl.text = messageModel.introduce;
    [self.img sd_setImageWithURL:[NSURL URLWithString:messageModel.listImg] placeholderImage:[UIImage imageNamed:@"message01"]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
   
    self.timeLbl.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[messageModel.sTime[@"time"] doubleValue]/1000.0]];
}
@end
