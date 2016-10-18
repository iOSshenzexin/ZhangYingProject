//
//  ZXCommissionListController.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXAccountInfoModel.h"
@class ZXCommissionListController;
@protocol ZXCommissionListControllerDelegate <NSObject>

@optional

- (void)ZXCommissionListControllerDelegatePassAccountModel:(ZXCommissionListController *)vc;

@end

@interface ZXCommissionListController : UIViewController

@property (nonatomic,weak) id <ZXCommissionListControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,copy) NSString *withdraw;

@property (nonatomic,strong) ZXAccountInfoModel *accountModel;

+(ZXCommissionListController *)sharedZXCommissionListController;
@end
