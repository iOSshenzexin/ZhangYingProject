//
//  UITextField+ZXTF.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/9/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ZXTF)
+ (void)setupTextFieldImageView:(UITextField *)textField image:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor viewMode:(UITextFieldViewMode)viewMode;
@end
