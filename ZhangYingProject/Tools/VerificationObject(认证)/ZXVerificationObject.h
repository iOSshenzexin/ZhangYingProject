//
//  ZXVerificationObject.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/9/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//  号码认证

#import <Foundation/Foundation.h>

@interface ZXVerificationObject : NSObject

/** 手机号判断 (包括移动,联通,电信) */
+ (BOOL)validateMobile:(NSString *)mobile;

/** 手机验证码判断(要求纯数字) */
+ (BOOL)validateNumber:(NSString *)verificationCode;

/** 邮箱有效性判断 */
+ (BOOL) validateEmail:(NSString *)email;


/** 判断长度大于6位小于20位并是否同时包含且只有数字和字母 */
+ (BOOL)validatePassWord:(NSString *)passWord;

/** 身份证有效性验证 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;


@end
