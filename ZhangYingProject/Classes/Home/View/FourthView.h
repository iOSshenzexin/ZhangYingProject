//
//  FourthView.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClick)(NSInteger tag);

@interface FourthView : UIView

- (IBAction)didClickSelectedContent:(id)sender;

@property (nonatomic,copy) buttonClick btnClick;


@end
