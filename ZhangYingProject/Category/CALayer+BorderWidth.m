//
//  CALayer+BorderWidth.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/11.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "CALayer+BorderWidth.h"

@implementation CALayer (BorderWidth)

- (void)setBorderColorWithUIColor:(UIColor *)color{
    self.borderColor = color.CGColor;
}
@end
