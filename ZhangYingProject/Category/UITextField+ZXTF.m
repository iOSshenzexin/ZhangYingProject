
//
//  UITextField+ZXTF.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/9/14.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "UITextField+ZXTF.h"

@implementation UITextField (ZXTF)

+ (void)setupTextFieldImageView:(UITextField *)textField image:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor viewMode:(UITextFieldViewMode)viewMode{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, textField.frame.size.height)];
    UIImageView *leftImage = [[UIImageView alloc] init];
    leftImage.bounds = CGRectMake(0, 0, 18, 18);
    leftImage.center = leftView.center;
    leftImage.image = image;
    [leftView addSubview:leftImage];
    
    textField.leftView = leftView;
    textField.leftViewMode = viewMode;
    textField.layer.borderWidth = borderWidth;
    textField.layer.borderColor = [borderColor CGColor];
}
@end
