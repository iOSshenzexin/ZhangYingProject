//
//  BlockView.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/10.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ sortBlock )(int selectedId);
@interface BlockView : UIView


- (CGFloat)setupBlockViewContent:(NSArray *)titleArray buttonBorderWidth:(CGFloat )borderWidth borderColor:(UIColor *)borderColor title:(NSString *)title;

-(void)setupSortBlockContentView:(NSArray *)titleArray;

@property (nonatomic,copy) sortBlock clickBlock;

@end
