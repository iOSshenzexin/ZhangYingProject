//
//  FloatingView.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DownLoadBlock) ();
@interface FloatingView : UIView

@property (nonatomic ,assign) CGPoint startPoint;//触摸起始点

@property (nonatomic ,assign) CGPoint endPoint;//触摸结束点

@property (nonatomic ,copy) DownLoadBlock downLoadBlock;

@property (nonatomic,strong) UIView *popView;

@end
