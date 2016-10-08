//
//  ZXLoginModel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXLoginModel : NSObject<NSCoding>
/*
{
    allCommision = 0;
    businessCard = "";
    cardNumber = "";
    commision = 0;
    email = 112;
    headPortrait = "/img/pic/1474352879357weixin.png";
    id = 12;
    isDelete = 1;
    lastLoginIp = "";
    lastLoginTime = "<null>";
    name = 11;
    nickname = "\U5973\U58eb";
    password = 7CF28171508943DEEFEE4B3DA7F41923;
    phone = 15192712510;
    rePhone = "";
    regName = "";
    regStatus = 1;
    regTime = "<null>";
    status = 1;
};*/
/** 头像 */
@property (nonatomic,copy) NSString *headPortrait;

/** 用户邮箱 */
@property (nonatomic,copy)  NSString *email;

/** 用户姓名 */
@property (nonatomic,copy) NSString *name;

/** 用户昵称 */
@property (nonatomic,copy) NSString *nickname;

/** 用户id */
@property (nonatomic,copy) NSString *mid;

/** 用户账号 */
@property (nonatomic,assign) double phone;


/**  */
@property (nonatomic,assign) float allCommision;

@property (nonatomic,assign) float commision;

@property (nonatomic,copy) NSString *address;

@end
