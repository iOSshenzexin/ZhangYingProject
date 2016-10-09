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

#import "TrustCustomCell.h"
#import "ZXProductCell.h"
#import "ZXProduct.h"

#import "ProductDetailController.h"

#import "ZXAdvertisementController.h"
#import "LoginController.h"

#import "ProductController.h"
#import "ZXHomeProductController.h"
@interface HomeController ()<KNBannerViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak,nonatomic) UITextField *textField;

@property (nonatomic,strong) UITableView *tv;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,copy)  NSArray *pictureArray;

@property (nonatomic,copy) NSMutableDictionary *dataDictionary;


@property (nonatomic,copy)  NSArray *hotRecommandationArray;

@end

@implementation HomeController

+(HomeController *)sharedHomeController{
    static HomeController *vc = nil;
    if (!vc) {
        vc = [[HomeController alloc] init
              ];
    }
    return vc;
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if(appDlg.isReachable == NO){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry,您当前网络连接异常!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加搜索框
    self.navigationItem.titleView = [ZXSearchBar searchBar];
    UITextField *txt = (UITextField *)self.navigationItem.titleView;
    txt.placeholder = @"请输入您要搜索的产品";
    txt.delegate = self;
    self.textField = txt;
    self.tableView = [self createTableView];

    //创建模块视图
    [self requestHomeData];

    [self setupView];
    
    ProductController *vc = [ProductController sharedProductController];
    [ZXNotificationCeter addObserver:vc selector:@selector(getProductListInfomation:) name: ZXSelectedProductStyleNotification object:nil];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.contentOffset = CGPointMake(0, 64);
    self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    //[self.view setNeedsLayout];
}



- (void)requestHomeData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //我的业绩 Home_MyGrade_Url
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    if(app.isLogin) {
        ZXLoginModel *model = AppLoginModel;
        parameters[@"mid"] = model.mid;
    }
    [manager POST:Home_MyGrade_Url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataDictionary = responseObject[@"data"];
        for (UIView *subview in self.scrollView.subviews) {
            if ([subview isKindOfClass:[FirstView class]]) {
                FirstView *firstCustomView = (FirstView *)subview;
                firstCustomView.lbl1.text = [NSString stringWithFormat:@"关注 %d 款",[self.dataDictionary[@"collCount"] intValue]];
                firstCustomView.lbl2.text = [NSString stringWithFormat:@"订单 %d 单",[self.dataDictionary[@"orderCount"] intValue]];
                
                AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
                if (app.isLogin) {
                    ZXLoginModel *model = AppLoginModel;
                    if (model.allCommision / 10000 > 0) {
                         firstCustomView.lbl3.text = [NSString stringWithFormat:@"佣金 %.2f万元",model.allCommision/10000.0];
                    }else{
                    firstCustomView.lbl3.text = [NSString stringWithFormat:@"佣金 %.f 元",model.allCommision];
                    }
                }
                firstCustomView.lbl4.text = [NSString stringWithFormat:@"%@款",self.dataDictionary[@"productCount1"]];
                firstCustomView.lbl5.text = [NSString stringWithFormat:@"%@款",self.dataDictionary[@"productCount2"]];
                firstCustomView.lbl6.text = [NSString stringWithFormat:@"%@款",self.dataDictionary[@"productCount3"]];
                firstCustomView.lbl7.text = [NSString stringWithFormat:@"%@款",self.dataDictionary[@"productCount4"]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
    // 广告
    [manager POST:Home_AdvertisementList_Url parameters:nil progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         //添加顶部轮播图
          [self.scrollView addSubview:[TopBannerTool setupNetWorkBannerViewAtViewController:self ImageArray:responseObject[@"data"] IntroduceStringArray:responseObject[@"data"]]];
         self.pictureArray = responseObject[@"data"];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         ZXError
     }];
    
    //热门推荐
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageIndex"] = @(0);
    [manager POST:Home_HotRecommandation_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.hotRecommandationArray = [ZXProduct mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        [self.tableView reloadData];
        [self.view setNeedsLayout];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}

- (UITableView *)createTableView{
    UITableView *homeVC = [[UITableView alloc] init] ;
    homeVC.dataSource = self;
    homeVC.delegate = self;
    homeVC.rowHeight = 120;
    homeVC.contentInset = UIEdgeInsetsMake(-5, 0, 0, 0);
    homeVC.backgroundColor = [UIColor clearColor];
    homeVC.scrollEnabled = NO;
    return homeVC;
}

   /* 轮播图点击响应处理 */
- (void)bannerView:(KNBannerView *)bannerView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSInteger)index{
    ZXAdvertisementController *vc = [[ZXAdvertisementController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = self.pictureArray[index][@"picTitle"];
    vc.url = self.pictureArray[index][@"picUrl"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    SearchController *vc = [SearchController sharedSearchController];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FirstView *firstCustomView = self.scrollView.subviews[0];
    firstCustomView.frame = CGRectMake(0, 180, ScreenW, 200);
    ThirdView *thirdView = self.scrollView.subviews[1];
    thirdView.frame = CGRectMake(0, CGRectGetMaxY(firstCustomView.frame) - 5, ScreenW, 30);
    self.tableView = self.scrollView.subviews[2];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(thirdView.frame), ScreenW, (self.hotRecommandationArray.count) * 120);
    FourthView *fourthView = self.scrollView.subviews[3];
    fourthView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame)+10, ScreenW, 85);
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(fourthView.frame)+30);
}

- (void)setupView{
    //第一部分 我的业绩
    FirstView *firstCustomView = [[[NSBundle mainBundle]loadNibNamed:@"FirstView" owner:self options:nil] firstObject];
    [self.scrollView addSubview:firstCustomView];
    firstCustomView.block = ^(NSInteger index){
        TabbarController *tab = (TabbarController *) ZXApplication.keyWindow.rootViewController;
        tab.selectedIndex = 0;
        int selectIndex = (int)index;
        [ZXNotificationCeter postNotificationName:ZXSelectedProductStyleNotification object:nil userInfo:@{@"index":@((selectIndex-20))}];
    };

    //第二部分
    ThirdView *thirdView = [[[NSBundle mainBundle]loadNibNamed:@"ThirdView" owner:self options:nil] firstObject];
    [self.scrollView addSubview:thirdView];
    //第三部分
    [self.scrollView addSubview:self.tableView];
    
    FourthView *fourthView = [[[NSBundle mainBundle]loadNibNamed:@"FourthView" owner:self options:nil] firstObject];
    fourthView.btnClick = ^(NSInteger index){
        UIButton *btn = [fourthView viewWithTag:index];
        ZXHomeProductController *vc = [[ZXHomeProductController alloc] init];
        vc.title = btn.titleLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    [self.scrollView addSubview:fourthView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hotRecommandationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXProductCell *cell = [ZXProductCell cellWithTableView:tableView];
    cell.product = self.hotRecommandationArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    if (app.isLogin) {
        ZXProductCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        ProductDetailController *vc = [[ProductDetailController alloc] init];
        vc.title = cell.product.productTitle;
        ZXProduct *product = self.hotRecommandationArray[indexPath.row];
        vc.product_id = product.proId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginController *login = [[LoginController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        [kWindowRootController presentViewController:nav animated:YES completion:nil];
    }
}

-(void)dealloc
{
    [ZXNotificationCeter removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
     self.view = nil;

}


@end
