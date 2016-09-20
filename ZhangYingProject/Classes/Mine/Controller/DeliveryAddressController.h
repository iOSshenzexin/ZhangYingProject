//
//  DeliveryAddressController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/25.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeliveryAddressController;
@protocol DeliveryAddressControllerDelegate <NSObject>

@optional

- (void)deliveryAddress:(DeliveryAddressController *)vc;


@end

@interface DeliveryAddressController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *addressTableView;

@property (nonatomic,copy) NSString *address;


@property (weak,nonatomic) id<DeliveryAddressControllerDelegate> delegate;

+(DeliveryAddressController *)sharedDeliveryAddressController;
@end