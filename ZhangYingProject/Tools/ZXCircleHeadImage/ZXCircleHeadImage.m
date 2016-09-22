//
//  ZXCircleHeadImage.m
//  封装UIImage类
//
//  Created by 杨晓婧 on 16/7/7.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXCircleHeadImage.h"

@implementation ZXCircleHeadImage

+ (UIImage *)clipImageForHeadImage:(UIImage *)image andBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color{

    CGFloat borderW = borderWidth;
    CGFloat imageW = image.size.width + 2 * borderW;
    
    CGFloat imageH = image.size.height + 2 * borderW;

    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color set];
    
    CGFloat bigRadius = imageW * 0.5;
    CGFloat centerX = bigRadius;
    CGFloat centerY = bigRadius;
    CGContextAddArc(context, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    //CGContextFillPath(context);
    CGContextStrokePath(context);
    
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(context, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    CGContextStrokePath(context);

    //CGContextClip(context);
    [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (UIImage*) clipOriginImage:(UIImage *)image scaleToSize:(CGSize)size borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    UIGraphicsBeginImageContext(size); //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return [self clipImageForHeadImage:scaledImage andBorderWidth:borderWidth borderColor:borderColor];
}

@end


