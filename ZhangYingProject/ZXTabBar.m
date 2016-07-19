//
//  ZXTabBar.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXTabBar.h"
#import "UIView+Extension.h"
@interface ZXTabBar()

@property (nonatomic, weak) UIButton *centerBtn;


@end
@implementation ZXTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"nav05_normal"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"nav05_click"] forState:UIControlStateSelected];
        //[plusBtn setImage:[UIImage imageNamed:@"nav05_click"] forState:UIControlStateNormal];
        //[plusBtn setImage:[UIImage imageNamed:@"nav05_normal"] forState:UIControlStateSelected];
        
        plusBtn.size = plusBtn.currentBackgroundImage.size;

        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.centerBtn = plusBtn;
    }
    return self;
}


- (void)plusBtnClick{
    // 通知代理
    if ([self.zxDelegate respondsToSelector:@selector(tabBarDidClickCenterButton:)]) {
        [self.centerBtn setBackgroundImage:[UIImage imageNamed:@"nav05_click"] forState:UIControlStateSelected];
        [self.zxDelegate tabBarDidClickCenterButton:self];
    }
}

/**
 *  想要重新排布系统控件subview的布局，推荐重写layoutSubviews，在调用父类布局后重新排布。
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 1.设置加号按钮的位置
    self.centerBtn.centerX = self.width * 0.5;
    self.centerBtn.centerY = self.height * 0.5;
    
    // 2.设置其他tabbarButton的frame
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置x
            child.x = tabBarButtonIndex * tabBarButtonW;
            // 设置宽度
            child.width = tabBarButtonW;
            // 增加索引
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }
}
@end
