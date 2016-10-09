//
//  DeliveryAddressController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/25.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXAddressModel.h"
@class DeliveryAddressController;
@protocol DeliveryAddressControllerDelegate <NSObject>

@optional

- (void)deliveryAddress:(DeliveryAddressController *)vc;


@end

@interface DeliveryAddressController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *addressTableView;

@property (nonatomic,copy) NSString *address;

@property (nonatomic,copy) NSString *addressID;

@property (nonatomic,strong) ZXAddressModel *addressModel;

@property (weak, nonatomic) IBOutlet UIButton *submitChange;


@property (weak,nonatomic) id<DeliveryAddressControllerDelegate> delegate;

+(DeliveryAddressController *)sharedDeliveryAddressController;
@end
