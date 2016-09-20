//
//  ZXNavgaitonController.m
//  PocketOrder
//
//  Created by 杨晓婧 on 16/9/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXNavgaitonController.h"
#import "UIBarButtonItem+ZXItem.h"
@interface ZXNavgaitonController ()<UIGestureRecognizerDelegate>

@end

@implementation ZXNavgaitonController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    // 控制手势什么时候触发,只有非根控制器才需要触发手势
    pan.delegate = self;
    
    // 禁止之前手势
    self.interactivePopGestureRecognizer.enabled = NO;
    // 假死状态:程序还在运行,但是界面死了.
}

//手势对应的事件
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{
    
}

#pragma mark - UIGestureRecognizerDelegate
// 决定是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
       // 非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
       // 设置返回按钮,只有非根控制器
     viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"back"] highImage:[UIImage imageNamed:@""]  target:self action:@selector(back) title:@""];
    }
    // 真正在跳转
    [super pushViewController:viewController animated:animated];
}



- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
