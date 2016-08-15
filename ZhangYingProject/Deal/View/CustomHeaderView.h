//
//  CustomHeaderView.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShareModel.h"

@class CustomHeaderView;
@protocol CustomHeaderViewDelegate <NSObject>

@optional

- (void)didClickOpenHeaderVeiw:(CustomHeaderView *)headerView;


@end

@interface CustomHeaderView : UITableViewHeaderFooterView

+(instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic,weak) id <CustomHeaderViewDelegate> delegate;

@property (nonatomic,strong) ShareModel *model;


@end
