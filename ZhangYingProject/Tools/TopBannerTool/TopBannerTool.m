//
//  TopBannerTool.m
//  PocketMenuProject
//
//  Created by 杨晓婧 on 16/7/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "TopBannerTool.h"
@interface TopBannerTool()

@end
@implementation TopBannerTool

+ (UIView *)setupNetWorkBannerViewAtViewController:(UIViewController<KNBannerViewDelegate> *)vc ImageArray:(NSArray *)images IntroduceStringArray:(NSArray *)introduces {
    NSMutableArray *imgArr = [NSMutableArray array];
    for (NSInteger i = 0; i < images.count; i++) {
        NSString *urlString = [baseUrl stringByAppendingString:images[i][@"picAddr"]];
        [imgArr addObject:urlString];
    }
    // 设置 网络 轮播图
    KNBannerView *bannerView = [KNBannerView bannerViewWithNetWorkImagesArr:imgArr frame:CGRectMake(0, 0, ScreenW, 180)];
    bannerView.delegate = vc;
    
    NSMutableArray *IntroduceArr = [NSMutableArray array];
    for (NSInteger i = 0; i < introduces.count; i++) {
        [IntroduceArr addObject:introduces[i][@"picTitle"]];
    }
    bannerView.IntroduceStringArr = IntroduceArr;
    /****************************** == 占位图 == ********************************/
    bannerView.placeHolder = @"3";
    bannerView.tag = 100;
    return bannerView;
}

+ (UIView *)setupLocatioBannerViewAtViewController:(UIViewController<KNBannerViewDelegate> *)vc{
    NSString *img1 = @"1";
    NSString *img2 = @"2.jpg";
    NSString *img3 = @"3.jpg";
    NSString *img4 = @"4.jpg";
    NSString *img5 = @"5.jpg";
    NSArray *imgArr = [NSArray arrayWithObjects:img1,img2,img3,img4,img5, nil];
    NSLog(@"vc.view.frame.size.width:%f vc:%@",vc.view.frame.size.width,vc);
    // 设置 本地 轮播图
    KNBannerView *bannerView = [KNBannerView bannerViewWithLocationImagesArr:imgArr frame:CGRectMake(0, 0, ScreenW, 180)];
    /****************************** == 描述文字 == ********************************/
    NSString *string1 = @"这是本地图片";
    NSString *string2 = @"如果觉得还不错";
    NSString *string3 = @"记得给我点赞哦";
    NSString *string4 = @"我会更加努力的";
    NSString *string5 = @"谢谢大家的支持!";
    NSMutableArray *IntroduceArr = [NSMutableArray array];
    [IntroduceArr addObject:string1];
    [IntroduceArr addObject:string2];
    [IntroduceArr addObject:string3];
    [IntroduceArr addObject:string4];
    [IntroduceArr addObject:string5];
    bannerView.IntroduceStringArr = IntroduceArr;
    bannerView.timeInterval = 4; // 图片轮播的时间间隔
    bannerView.IntroduceTextFont = [UIFont systemFontOfSize:17];// 介绍文字字体大小
    bannerView.IntroduceBackGroundAlpha = 1.0;// 介绍文字的透明度
    bannerView.IntroduceBackGroundColor = [UIColor blackColor]; // 介绍文字的背景色
    //    bannerView.IntroduceHeight = 60;// 介绍文字的高度
    bannerView.IntroduceTextColor = [UIColor orangeColor]; // 介绍文字的颜色
    bannerView.PageIndicatorTintColor = [UIColor whiteColor];// pageControl的 其他'点'的颜色
    bannerView.CurrentPageIndicatorTintColor = [UIColor orangeColor];// pageControl的 当前'点'的颜色
    bannerView.pageControlStyle = KNPageControlStyleLeft;// pageControl 对其方式
    bannerView.IntroduceStyle = KNIntroduceStyleRight;// 介绍文字的对其方式
    
    bannerView.delegate = vc;
    bannerView.tag = 200;
    return bannerView;
    
}



@end
