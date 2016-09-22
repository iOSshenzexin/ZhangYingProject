//
//  NSString+ZXMD5Hashing.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZXMD5Hashing)

-(NSString *)stringMD5Hash;

+ (NSString *)firstEncryptionAfterTheChaoticSequence:(NSString *)str;

@end
