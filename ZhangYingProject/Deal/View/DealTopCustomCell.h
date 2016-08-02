//
//  DealTopCustomCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealTopCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIButton *showCardBtn;
@end
