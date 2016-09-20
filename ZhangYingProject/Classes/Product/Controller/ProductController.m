//
//  ProductController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductController.h"
#import "SecondView.h"
#import "ZXProductCell.h"
#import "ZXSearchBar.h"
#import "SearchController.h"
#import "ProductDetailController.h"

#import "FilterBottomView.h"
#import "BlockView.h"

#import "ZXTopic.h"
#import "ZXProduct.h"

#define DurationTime 0.35

@interface ProductController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak,nonatomic) UITextField *textField;

@property (nonatomic,copy) NSMutableArray *titleArray;

@property (nonatomic,copy) NSMutableArray *productArray;

/** 信托 */
@property (nonatomic,strong) UITableView *trustTableView;

@property (nonatomic,strong) UIView *showView;
@property (nonatomic,strong) UIView *showSortView;

@property (nonatomic,strong) UIScrollView *sortView;
@property (nonatomic,strong) UIScrollView *filterView;

@property (nonatomic,assign) BOOL isShow;

@end

@implementation ProductController

-(void)viewWilllAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(!appDlg.isReachable){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry,您当前网络连接异常!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    //加载网络数据
}

 static NSString *str = @"cellId";
-(UITableView *)trustTableView{
    if (!_trustTableView) {
        _trustTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-148)];
        _trustTableView.dataSource = self;
        _trustTableView.delegate = self;
        _trustTableView.rowHeight = 120;
        [_trustTableView registerNib:[UINib nibWithNibName:@"ZXProductCell" bundle:nil] forCellReuseIdentifier:str];
        _trustTableView.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
        _trustTableView.backgroundColor = [UIColor clearColor];
    }
    return _trustTableView;
}

-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

-(NSMutableArray *)productArray{
    if (!_productArray) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBarSubviews];
    [self loadInternetData];
}

#pragma mark - 加载网络数据
- (void)loadInternetData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:Product_Topic_Url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.titleArray = [ZXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self setupTopSegment];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXLog(@"%@",error);
    }];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"productType"] = @1;
    params[@"sort"] = @"0";
    [manager POST:Product_List_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.productArray = [ZXProduct mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        [self.trustTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXLog(@"%@",error);
    }];
    
}

#pragma mark UITextFielDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    SearchController *vc = [SearchController sharedSearchController];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}

- (void)setupNavigationBarSubviews{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 60, 30);
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [leftBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(didClickFilter:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = leftBtn.frame;
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    rightBtn.titleLabel.font = leftBtn.titleLabel.font;
    [rightBtn setTitle:@"排序" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(didClickSort:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.titleView = [ZXSearchBar searchBar];
    UITextField *txt = (UITextField *)self.navigationItem.titleView;
    txt.placeholder = @"这里有你适合的...";
    txt.delegate = self;
    self.textField = txt;
}

static BOOL isCreated = YES;

#pragma mark       左边筛选按钮对应事件
- (void)didClickFilter:(UIButton *)btn{
    UIApplication *app = [UIApplication sharedApplication];
    if (self.isShow == YES) {
        if (self.showSortView) {
            self.showSortView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0];
            [self.showSortView removeFromSuperview];
        }
    }
    if (isCreated) {
        UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0,64, ScreenW, ScreenH - 64)];
        self.showView = showView;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 0)];
        scrollView.backgroundColor = [UIColor whiteColor];
        
        self.filterView = scrollView ;
        [self.showView addSubview:self.filterView];
        
        
        for (NSInteger i = 0; i < 6; i ++) {
            BlockView *block = [[BlockView alloc] initWithFrame:CGRectMake(0, 0 + i * 130, ScreenW, 130)];
            [block setupBlockViewContent:[NSArray arrayWithObjects:@"全部",@"<12个月",@"12个月",@"13-23个月",@"13-23个月",@"13-23个月",@"13-23个月", nil] buttonBorderWidth:3 borderColor:[UIColor redColor]  title:@"产品期限"];
            [self.filterView addSubview:block];
            }
        
        FilterBottomView *filterBottomView = [[[NSBundle mainBundle]loadNibNamed:@"FilterBottomView" owner:self options:nil] firstObject];
        [filterBottomView.cancleBtn addTarget:self action:@selector(hideShowView:) forControlEvents:UIControlEventTouchUpInside];
        [filterBottomView.confirmBtn addTarget:self action:@selector(hideShowView:) forControlEvents:UIControlEventTouchUpInside];
        
        filterBottomView.frame = CGRectMake(0,780, ScreenW, 60);
        UIColor *color = RGB(242, 242, 242, 1);
        
        filterBottomView.layer.borderColor = color.CGColor;
        filterBottomView.layer.borderWidth = 1;
        
        [scrollView addSubview:filterBottomView];
        
        scrollView.contentSize = CGSizeMake(ScreenW, 840);
        
        
        [UIView animateWithDuration:DurationTime animations:^{
            self.showView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0  blue:255/255.0  alpha:1];
        }];

        [UIView animateWithDuration:DurationTime animations:^{
            self.filterView.frame = CGRectMake(0, 64, self.filterView.frame.size.width,ScreenH - 64);
        }];
        [app.keyWindow insertSubview:self.filterView atIndex:3];
        self.isShow = YES;
    }else{
        [UIView animateWithDuration:DurationTime animations:^{
            self.filterView.frame = CGRectMake(0, 64, self.filterView.frame.size.width, 0);
        }completion:nil];
        [UIView animateWithDuration:DurationTime animations:^{}completion:^(BOOL finished) {
            self.showView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0  blue:255/255.0  alpha:0];
            [self.showView removeFromSuperview];
        }];
    }
    isCreated = !isCreated;
}

  // 收起列表
- (void)hideShowView:(UIButton *)btn{
    [UIView animateWithDuration:DurationTime animations:^{
        self.filterView.frame = CGRectMake(0, 64, self.filterView.frame.size.width, 0);
    }completion:nil];
    [UIView animateWithDuration:DurationTime animations:^{}completion:^(BOOL finished) {
        self.showView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0  blue:255/255.0  alpha:0];
        [self.showView removeFromSuperview];
    }];
    isCreated = YES;
}


static BOOL isSetUp = YES;

#pragma mark - 右边排序按钮对应事件
- (void)didClickSort:(UIButton *)btn{
    UIApplication *app = [UIApplication sharedApplication];
    if (self.isShow == YES) {
        if (self.showView) {
            self.showView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0  blue:255/255.0  alpha:0];
            [self.filterView removeFromSuperview];
            [self.showView removeFromSuperview];
        }
    }
    if (isSetUp) {
        UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0,64, ScreenW, ScreenH-64)];
        
        self.showSortView = showView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideShowSortView:)];
        [self.showSortView addGestureRecognizer:tap];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
        scrollView.backgroundColor = [UIColor whiteColor];
        self.sortView = scrollView ;
        
        [self.showSortView addSubview:self.sortView];
        BlockView *block = [[BlockView alloc] initWithFrame:CGRectMake(0,0, ScreenW, 130)];
        [block setupSortBlockContentView:[NSArray arrayWithObjects:@"全部",@"<12个月",@"12个月",@"13-23个月",@"13-23个月",@"13-23个月",@"13-23个月", nil]];
        [self.sortView addSubview:block];
        [UIView animateWithDuration:DurationTime animations:^{
            self.showSortView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0.65];}];
        [UIView animateWithDuration:DurationTime animations:^{
            self.sortView.frame = CGRectMake(0, 0, self.sortView.frame.size.width,130);
            }completion:nil];
        [app.keyWindow insertSubview:self.showSortView atIndex:4];
        self.isShow = YES;
    }else{
        [UIView animateWithDuration:DurationTime animations:^{
            self.sortView.frame = CGRectMake(0, 0, self.sortView.frame.size.width, 0);
        }completion:^(BOOL finished) {
            self.showSortView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0];
            [self.showSortView removeFromSuperview];
        }];
    }
    isSetUp = !isSetUp;
}

- (void)hideShowSortView:(UITapGestureRecognizer *)tap{
    CGPoint point =[tap locationInView:tap.view];
    if (point.y > 130) {
        [UIView animateWithDuration:DurationTime animations:^{
            self.sortView.frame = CGRectMake(0, 0, self.sortView.frame.size.width, 0);
        }completion:^(BOOL finished) {
            self.showSortView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0];
            [self.showSortView removeFromSuperview];
        }];
        isSetUp = YES;
    }
}

- (void)setupTopSegment{
    self.automaticallyAdjustsScrollViewInsets= NO; //iOS7新增属性
    NSMutableArray *contentArray= [NSMutableArray array];
    NSMutableArray *topics= [NSMutableArray array];

    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        UIView *view= [[UIView alloc] init];
        ZXTopic *topic = self.titleArray[i];
        [topics addObject:topic.typeName];
        view.backgroundColor = RGB(242, 242, 242, 1);
        [contentArray addObject:view];
    }
    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) titleArray:topics contentViewArray:contentArray];
    scView.block = ^(int index){
        NSLog(@"result %d",index);
        
        
    };
    [self.view addSubview:scView];
    
    //信托
    UIView *view = (UIView *)contentArray[0];
    [view addSubview:self.trustTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXProductCell *cell = [ZXProductCell cellWithTableView:tableView];
    cell.product = self.productArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXProductCell *cell = [self.trustTableView cellForRowAtIndexPath:indexPath];
    ProductDetailController *vc = [[ProductDetailController alloc] init];
    vc.title = cell.product.productTitle;
    ZXProduct *product = self.productArray[indexPath.row];
    vc.product_id = product.productType;
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
