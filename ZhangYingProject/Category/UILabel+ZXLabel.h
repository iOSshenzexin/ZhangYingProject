//
//  UILabel+ZXLabel.h
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/19.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZXLabel)
+(NSMutableAttributedString *)labelWithRichNumber:(NSString*)labelString Color:(UIColor *) color FontSize:(CGFloat)size;
@end
