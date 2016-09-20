//
//  ZXPop.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXPop.h"

#import "ZXWindowiew.h"
@implementation ZXPop

-(void)addPopWithView:(UIView *)mainView{
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 49)];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0.5;
    shadowView.tag = 102;
    [mainView addSubview:shadowView];
    
    
    ZXWindowiew *windowView = [[[NSBundle mainBundle]loadNibNamed:@"ZXWindowiew" owner:self options:nil] firstObject];
    self.mainView = windowView;
    windowView.tag = 103;
    windowView.center = shadowView.center;
    windowView.bounds = CGRectMake(0, 0, 260, 340);
    windowView.layer.cornerRadius = 8;
    windowView.layer.masksToBounds = YES;
    [mainView addSubview:windowView];
    [ZXPop animationAlert:windowView];
}

-(void)setMainView:(UIView *)mainView{
    _mainView = mainView;
}

/**弹窗动画*/
+ (void)animationAlert:(UIView *)view{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
}


- (void)didClickCancleBtn:(UIButton *)btn{
    NSLog(@"%@",NSStringFromCGRect(btn.superview.frame));
    NSLog(@"%@",NSStringFromCGRect(btn.superview.superview.frame));
    [btn.superview.superview removeFromSuperview];
}

@end
