//
//  CustomAnnouncementCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "CustomAnnouncementCell.h"

@implementation CustomAnnouncementCell

static NSString *customAnnouncementCell= @"CustomAnnouncementCell";

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CustomAnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:customAnnouncementCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomAnnouncementCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setAnnounceModel:(ZXAnnounceModel *)announceModel
{
    _announceModel = announceModel;
    self.titleLbl.text = announceModel.title;
    
    self.subtitleLbl.attributedText = [UILabel labelWithRichNumber:announceModel.content Color:[UIColor redColor] FontSize:16];
    ;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.timeLbl.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[announceModel.sTime[@"time"] doubleValue]/1000.0]];
}

@end
