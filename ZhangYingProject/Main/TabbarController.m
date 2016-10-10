//
//  TabbarController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "TabbarController.h"
#import "DealController.h"
#import "MessageController.h"
#import "HomeController.h"
#import "MineController.h"
#import "ProductController.h"

#import "ZXNavgaitonController.h"
@interface TabbarController ()

@property (nonatomic,weak) UIControl *previousRepeatClickedButton;

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildViewController];
    [self getTabBarButtonRepeatedClicked];
}

- (void)getTabBarButtonRepeatedClicked
{
    UITabBarItem *tabBarItem = self.tabBar.items[2];
    tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    for (UIControl *tabBarButron in self.tabBar.subviews) {
        if ([tabBarButron isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
           self.previousRepeatClickedButton = tabBarButron;
            [tabBarButron addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)tabBarButtonClicked:(UIControl *)tabBarButton
{
    if (self.previousRepeatClickedButton == tabBarButton) {
       ZXFunc
       [ZXNotificationCeter postNotificationName:ZXRepeatedClickTabbarButtonEventNotificationCeter object:nil];
    }
    self.previousRepeatClickedButton = tabBarButton;
}

+ (TabbarController *)sharedTabBarController{
    static TabbarController *vc = nil;
    if (!vc) {
        vc = [[TabbarController alloc] init];
    }
    return vc;
}

- (void)setUpAllChildViewController{
    // 1.添加第一个控制器
    ProductController *productVc = [[ProductController alloc]init];
    [self setUpOneChildViewController:productVc image:[UIImage imageNamed:@"nav01_normal"] selectImage:[UIImage imageNamed:@"nav01_click"] title:@"产品"];
    // 2.添加第2个控制器
    MessageController *messageVC = [[MessageController alloc]init];
    [self setUpOneChildViewController:messageVC image:[UIImage imageNamed:@"nav02_normal"] selectImage:[UIImage imageNamed:@"nav02_click"] title:@"消息"];
    // 3.添加第3个控制器
    HomeController *homeVC = [[HomeController alloc]init];
    [self setUpOneChildViewController:homeVC image:[UIImage imageNamed:@"nav05_normal"] selectImage:[UIImage imageNamed:@"nav05_click"] title:nil];
    // 4.添加第4个控制器
    DealController *dealVC = [DealController sharedDealController];
    [self setUpOneChildViewController:dealVC image:[UIImage imageNamed:@"nav03_normal"] selectImage:[UIImage imageNamed:@"nav03_click"]  title:@"交易"];
    // 5.添加第5个控制器
    MineController *mineVC = [[MineController alloc]init];
    [self setUpOneChildViewController:mineVC image:[UIImage imageNamed:@"nav04_normal"] selectImage:[UIImage imageNamed:@"nav04_click"]  title:@"我的"];
    [self setSelectedIndex:2];
    
}

- (void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title {
    ZXNavgaitonController *navC = [[ZXNavgaitonController alloc]initWithRootViewController:viewController];
    navC.title = title;
    navC.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     navC.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [navC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
    [navC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    viewController.navigationItem.title = title;
    [self addChildViewController:navC];
}





@end
