//
//  WithdrawCashController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawCashController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *withdrawCashTableView;
- (IBAction)didClickWithdrawCash:(id)sender;

@property (nonatomic,assign) BOOL changeCellStyle;
@property (weak, nonatomic) IBOutlet UILabel *explainLbl;

@property (weak, nonatomic) IBOutlet UIButton *withdrawCashBtn;
@end
