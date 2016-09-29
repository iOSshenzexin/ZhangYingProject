//
//  ZXReservationFailureController.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXReservationModel.h"
@interface ZXReservationFailureController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *productTitleLbl;

@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *identifierIdLbl;


@property (weak, nonatomic) IBOutlet UILabel *payDateLbl;

@property (weak, nonatomic) IBOutlet UILabel *payAmountLbl;


@property (weak, nonatomic) IBOutlet UILabel *telephoneLbl;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;


@property (nonatomic,copy) ZXReservationModel *reservationModel;

@end
