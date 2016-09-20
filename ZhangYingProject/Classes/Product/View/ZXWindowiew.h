//
//  ZXWindowiew.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXWindowiew : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextView *contentTxt;

@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@end
