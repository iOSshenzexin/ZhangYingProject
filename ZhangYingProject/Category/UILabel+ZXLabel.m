//
//  UILabel+ZXLabel.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "UILabel+ZXLabel.h"

@implementation UILabel (ZXLabel)

+(NSMutableAttributedString *)labelWithRichNumber:(NSString*)labelString Color:(UIColor *) color FontSize:(CGFloat)size
{
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"%",@"<"];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:labelString];
    for (int i = 0; i < labelString.length; i ++) {
        //这里的小技巧，每次只截取一个字符的范围
        NSString *a = [labelString substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:[UIFont systemFontOfSize:size]} range:NSMakeRange(i, 1)];
        }
    }
    //完成查找数字，最后将带有字体下划线的字符串显示在UILabel上
    return  attributeString;
}
@end
