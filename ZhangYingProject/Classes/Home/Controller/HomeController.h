//
//  HomeController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeController;

@protocol HomeControllerDelegate <NSObject>

@optional

- (void)didClickSearchBarShowKeyBoard:(HomeController *)vc;

@end

@interface HomeController : UIViewController

+ (HomeController *)sharedHomeController;

@property (nonatomic,weak) id<HomeControllerDelegate> delegate;


@end
