//
//  HomeController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "HomeController.h"
#import "SearchController.h"


#import "TopBannerTool.h"
#import "ZXSearchBar.h"
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"
#import "FourthView.h"
@interface HomeController ()<KNBannerViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak,nonatomic) UITextField *textField;
@property (nonatomic,strong) UITableView *tv;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加搜索框
    self.navigationItem.titleView = [ZXSearchBar searchBar];
    UITextField *txt = (UITextField *)self.navigationItem.titleView;
    txt.delegate = self;
    self.textField = txt;
    //添加轮播图
    [self.scrollView addSubview:[TopBannerTool setupNetWorkBannerViewAtViewController:self]];
    //创建模块视图
    [self setupView];
    //自定义返回按钮样式
    [self deleteBack];
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pictureNumber" object:nil userInfo:nil];
    self.hidesBottomBarWhenPushed = YES;
    SearchController *vc = [SearchController sharedSearchController];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    return NO;
}

- (void)setupView{
    //第一部分
    FirstView *firstCustomView = [[[NSBundle mainBundle]loadNibNamed:@"FirstView" owner:self options:nil] firstObject];
    firstCustomView.frame = CGRectMake(0, 180, ScreenW, 320);
    [self.scrollView addSubview:firstCustomView];
    
    CGFloat Y = CGRectGetMaxY(firstCustomView.frame)-20;

    //第二部分
    ThirdView *thirdView = [[[NSBundle mainBundle]loadNibNamed:@"ThirdView" owner:self options:nil] firstObject];
    //thirdView.layer.masksToBounds = YES
    thirdView.frame = CGRectMake(0, Y, ScreenW, 40);
    [self.scrollView addSubview:thirdView];

    
    CGFloat secondY = CGRectGetMaxY(thirdView.frame);
    //第三部分
    NSInteger count = 5;
    for (NSInteger i = 0; i < count; i ++) {
        SecondView *secondView = [[[NSBundle mainBundle]loadNibNamed:@"SecondView" owner:self options:nil] firstObject];
        secondView.frame = CGRectMake(8, secondY + i * 120, ScreenW - 16, 120);
        UIColor *color = RGB(240, 240, 240, 1);
        secondView.layer.borderColor = [color CGColor];
        secondView.layer.borderWidth = 0.6;
        [self.scrollView addSubview:secondView];
    }
    CGFloat scrollViewY =  secondY + count * 120;
    
    FourthView *fourthView = [[[NSBundle mainBundle]loadNibNamed:@"FourthView" owner:self options:nil] firstObject];
    fourthView.frame = CGRectMake(0, scrollViewY, ScreenW, 85);
    [self.scrollView addSubview:fourthView];
    CGFloat fourthViewY = scrollViewY + fourthView.bounds.size.height + 30;
    self.scrollView.contentSize = CGSizeMake(0, fourthViewY);
    
}

- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSInteger)index{
    NSLog(@"%zd---%zd",bannerView.tag,index);
  
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
