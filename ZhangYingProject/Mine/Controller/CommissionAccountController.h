//
//  CommissionAccountController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommissionAccountController;
@protocol CommissionAccountControllerDelegate <NSObject>

@optional

- (void)commissionAccountController:(CommissionAccountController *)vc andCardNumber:(NSString *)cardNumber cardStyle:(UIImage *)cardImage;

@end

@interface CommissionAccountController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *amountTableView;


@property (nonatomic,copy) NSString *registerAmount;

@property (nonatomic,weak) id <CommissionAccountControllerDelegate> delegate;

+ (CommissionAccountController *)sharedCommissionAccountController;
@end
