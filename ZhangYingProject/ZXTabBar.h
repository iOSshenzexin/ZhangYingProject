//
//  ZXTabBar.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXTabBar;

@protocol ZXTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickCenterButton:(ZXTabBar *)tabBar;

@end

@interface ZXTabBar : UITabBar

@property (nonatomic, weak) id<ZXTabBarDelegate> zxDelegate;

@end
