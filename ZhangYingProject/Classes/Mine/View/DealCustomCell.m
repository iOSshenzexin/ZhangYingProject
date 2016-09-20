//
//  DealCustomCell.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "DealCustomCell.h"

@implementation DealCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *leftView = [[UIView alloc] init];
    self.leftView = leftView;
    leftView.bounds = CGRectMake(0, 0, 100, 60);
    UILabel *leftLbl = [[UILabel alloc] init];
    leftLbl.frame = CGRectMake(0, 0, 100, 60);
    leftLbl.textAlignment = NSTextAlignmentCenter;
    [leftView addSubview:leftLbl];
    self.lbl = leftLbl;
    self.txtField.leftView = leftView;
    self.txtField.leftViewMode = UITextFieldViewModeAlways;
    self.layer.borderWidth = 0.6;
    UIColor *color = RGB(242, 242, 242, 0.8);;
    self.layer.borderColor = [color CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //[self setTextFieldLeftView];
    }
    return self;
}




@end