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
#import "ProductDetailController.h"

@interface HomeController ()<KNBannerViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak,nonatomic) UITextField *textField;
@property (nonatomic,strong) UITableView *tv;

@property (nonatomic,strong) UITableView *tableView;
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

static NSString *str = @"cellId";
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init] ;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 120;
        [_tableView registerNib:[UINib nibWithNibName:@"TrustCustomCell" bundle:nil] forCellReuseIdentifier:str];
        _tableView.contentInset = UIEdgeInsetsMake(-5, 0, 0, 0);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加搜索框
    self.navigationItem.titleView = [ZXSearchBar searchBar];
    UITextField *txt = (UITextField *)self.navigationItem.titleView;
    txt.placeholder = @"请输入您要搜索的产品";
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
    SearchController *vc = [SearchController sharedSearchController];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
    self.tableView.frame = CGRectMake(0, secondY, ScreenW, 5*120);
    [self.scrollView addSubview:self.tableView];
    CGFloat scrollViewY =  CGRectGetMaxY(self.tableView.frame) + 10;
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TrustCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[TrustCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.borderWidth = 5;
    UIColor *color = RGB(240, 240, 240, 1);
    cell.layer.borderColor = [color CGColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TrustCustomCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    ProductDetailController *vc = [[ProductDetailController alloc] init];
    vc.title = cell.titleLbl.text;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
