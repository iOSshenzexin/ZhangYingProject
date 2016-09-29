//
//  FirstView.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstView : UIView

typedef void(^buttonClick)(NSInteger tag);

@property (weak, nonatomic) IBOutlet UILabel *lbl1;

@property (weak, nonatomic) IBOutlet UILabel *lbl2;

@property (weak, nonatomic) IBOutlet UILabel *lbl3;


@property (weak, nonatomic) IBOutlet UILabel *lbl4;

@property (weak, nonatomic) IBOutlet UILabel *lbl5;

@property (weak, nonatomic) IBOutlet UILabel *lbl6;

@property (weak, nonatomic) IBOutlet UILabel *lbl7;

- (IBAction)didClickSelectProductStyle:(id)sender;

@property (nonatomic,copy) buttonClick block;

@end
