//
//  MyWalletController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWalletController : UIViewController
- (IBAction)didClickWithdrawCash:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *commissionLbl;
@property (weak, nonatomic) IBOutlet UILabel *alreadyMentionedLbl;
@property (weak, nonatomic) IBOutlet UILabel *canWithdrawLbl;

@end
