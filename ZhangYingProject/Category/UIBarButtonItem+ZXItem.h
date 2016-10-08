//
//  UIBarButtonItem+ZXItem.h
//  PocketOrder
//
//  Created by 杨晓婧 on 16/9/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZXItem)
// 创建UIBarButtonItem分类
+ (UIBarButtonItem *)itemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(nullable SEL)action;

+ (UIBarButtonItem *)backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

+ (UIBarButtonItem *)itemWithimage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action;

+(UIBarButtonItem *)itemWithFont:(CGFloat)fontsize title:(NSString *)title target:( id)target action:( SEL)action edgeInset:(CGFloat)EdgeInset;
@end
