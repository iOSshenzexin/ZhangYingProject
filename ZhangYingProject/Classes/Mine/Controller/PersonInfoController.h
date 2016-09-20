//
//  PersonInfoController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonInfoController;
@protocol PersonInfoControllerDelegate <NSObject>

@optional

- (void)setupUserHeadImage:(PersonInfoController *)vc;

@end

@interface PersonInfoController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak,nonatomic) id <PersonInfoControllerDelegate> delegate;

@property (nonatomic,strong) UIImage *headImage;

+ (PersonInfoController *)sharedPersonController;
@end
