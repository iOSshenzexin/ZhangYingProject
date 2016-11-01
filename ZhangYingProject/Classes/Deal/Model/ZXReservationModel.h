//
//  ZXReservationModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXReservationModel : NSObject
/**
 *"payAmount": "100.00",		//预计打款金额
 "phone": "15240248001",		//联系人手机号
 "payTimeStr": "2016-09-10",
 "status": 1,
 "proTitle": "中江信托-金鹤131号（第五期）",//产品名称
 "productId": 1,
 "bankCard": "images/banner.jpg",
 "address": "",			//收货地址
 "userName": "梁云",		//客户名称
 "memberId": 1,
 "cardNumber": "123124234124"	//证件编号
 
 cardnImage = "/images/banner.jpg";
 cardpImage = "/images/banner.jpg";
 certificateImage = "/
 
 
 */

@property (nonatomic,copy) NSString *payAmount;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *payTimeStr;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *proTitle;

@property (nonatomic,copy) NSString *productId;

@property (nonatomic,copy) NSString *bankCard;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *memberId;
@property (nonatomic,copy) NSString *cardNumber;

@property (nonatomic,copy) NSString *reserver_id;


@property (nonatomic,copy) NSString *cardnImage;
@property (nonatomic,copy) NSString *cardpImage;
@property (nonatomic,copy) NSString *certificateImage;

@end
