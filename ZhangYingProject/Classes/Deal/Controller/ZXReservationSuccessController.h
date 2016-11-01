//
//  ZXReservationSuccessController.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//  预约成功详情页

#import <UIKit/UIKit.h>

#import "ZXReservationModel.h"
@interface ZXReservationSuccessController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UILabel *useName;
@property (weak, nonatomic) IBOutlet UILabel *memberId;
@property (weak, nonatomic) IBOutlet UILabel *payDate;
@property (weak, nonatomic) IBOutlet UILabel *payAccount;
@property (weak, nonatomic) IBOutlet UILabel *telephone;
@property (weak, nonatomic) IBOutlet UILabel *address;


@property (nonatomic,strong) ZXReservationModel *reservationModel;

- (IBAction)didClickUplaodProofIno:(id)sender;

@end
