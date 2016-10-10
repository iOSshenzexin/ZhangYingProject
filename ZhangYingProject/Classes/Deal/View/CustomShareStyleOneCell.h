//
//  CustomShareStyleOneCell.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShareModel.h"
@interface CustomShareStyleOneCell : UITableViewCell

@property (nonatomic,copy) ShareModel *onceShareModel;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UILabel *readOrNoLbl;
@end
