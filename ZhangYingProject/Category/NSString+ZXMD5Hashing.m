//
//  NSString+ZXMD5Hashing.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "NSString+ZXMD5Hashing.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+hash.h"
@implementation NSString (ZXMD5Hashing)

-(NSString *)stringMD5Hash
{
    const char *cStr = self.UTF8String;
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

/**
 *  先加密, 后乱序
 */
+ (NSString *)firstEncryptionAfterTheChaoticSequence:(NSString *)str
{
     NSString *Sequence = [str stringMD5Hash];
    
     // 注册:  123 ----  2CB962AC59075B964B07152D234B7020
     // 登录: 123 --- 202CB962AC59075B964B07152D234B70

     NSString *header = [Sequence substringToIndex:2];
     NSString *footer = [Sequence substringFromIndex:2];
     Sequence = [footer stringByAppendingString:header];
     return Sequence;
     }
@end
