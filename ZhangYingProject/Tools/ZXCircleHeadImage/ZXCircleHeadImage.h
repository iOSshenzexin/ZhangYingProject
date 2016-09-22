//
//  ZXCircleHeadImage.h
//  封装UIImage类
//
//  Created by 杨晓婧 on 16/7/7.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//  用于生成带边框圆形头像的库  (作者:szx)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXCircleHeadImage : NSObject

  //外部使用只需调用这个方法就行
+ (UIImage*) clipOriginImage:(UIImage *)image scaleToSize:(CGSize)size borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


+ (UIImage *)clipImageForHeadImage:(UIImage *)image andBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;

@end
