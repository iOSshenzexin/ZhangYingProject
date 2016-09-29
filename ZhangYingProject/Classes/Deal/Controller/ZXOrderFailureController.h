//
//  ZXOrderFailureController.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXOrderModel.h"
@interface ZXOrderFailureController : UIViewController

@property (nonatomic,strong)  ZXOrderModel *orderModel;

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLbl;

@property (weak, nonatomic) IBOutlet UILabel *productTitleLbl;

@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;

@property (weak, nonatomic) IBOutlet UILabel *identifierIdLbl;

@property (weak, nonatomic) IBOutlet UILabel *payDateLbl;


@property (weak, nonatomic) IBOutlet UILabel *payAmountLbl;


@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

@property (weak, nonatomic) IBOutlet UILabel *telephoneLbl;


@property (weak, nonatomic) IBOutlet UIButton *card1;

@property (weak, nonatomic) IBOutlet UIButton *card2;

@property (weak, nonatomic) IBOutlet UIButton *card3;
@end
