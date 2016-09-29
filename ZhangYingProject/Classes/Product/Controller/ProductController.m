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
#import "ZXSortModel.h"

#import "LoginController.h"


#define DurationTime 0.35

@interface ProductController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak,nonatomic) UITextField *textField;

@property (nonatomic,copy) NSMutableArray *titleArray;

@property (nonatomic,copy) NSMutableArray *productArray;

/** 信托 */
@property (nonatomic,strong) UITableView *firstTV;
/** 资管 */
@property (nonatomic,strong) UITableView *secondTV;
/** 阳光私募 */
@property (nonatomic,strong) UITableView *threeTV;
/** 其他 */
@property (nonatomic,strong) UITableView *fourTV;

@property (nonatomic,strong) UIView *showView;
@property (nonatomic,strong) UIView *showSortView;

@property (nonatomic,strong) UIScrollView *sortView;
@property (nonatomic,strong) UIScrollView *filterView;

@property (nonatomic,assign) BOOL isShow;


@property (nonatomic,copy) NSMutableArray *models;


@property (nonatomic,copy) NSMutableArray *contentArray;

@property (nonatomic,copy) NSMutableArray *tableViewArray;

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

-(UITableView *)firstTV{
    if (!_firstTV) {
        _firstTV = [self createCustomTableView];
    }
    return _firstTV;
}

-(UITableView *)secondTV{
    if (!_secondTV) {
        _secondTV = [self createCustomTableView];
    }
    return _secondTV;
}

-(UITableView *)threeTV{
    if (!_threeTV) {
        _threeTV = [self createCustomTableView];
    }
    return _threeTV;
}

-(UITableView *)fourTV{
    if (!_fourTV) {
        _fourTV = [self createCustomTableView];
    }
    return _fourTV;
}

- (UITableView *)createCustomTableView
{
    UITableView *customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-148)];
    customTableView.dataSource = self;
    customTableView.delegate = self;
    customTableView.rowHeight = 120;
    customTableView.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
    customTableView.backgroundColor = [UIColor clearColor];
    return customTableView;
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
    
    self.number = 1;
    
    [self loadTopicTitle];
    
    [ZXNotificationCeter addObserver:self selector:@selector(getProductListInfomation:) name:ZXSelectedProductStyleNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestProductListWithUrl:Product_List_Url ModelClassString:@"ZXProduct" TableView:self.firstTV Status:self.number];
}


- (void)getProductListInfomation:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    int index = [dic[@"index"] intValue];
    ZXLog(@"Product Id :%d",index);
}


#pragma mark - 加载头部视图的网络数据
- (void)loadTopicTitle
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:Product_Topic_Url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.titleArray = [ZXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self setupTopSegment];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}
#pragma mark - 创建头部视图
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
    [(UIView *)contentArray[0] addSubview:self.firstTV];
    [(UIView *)contentArray[1] addSubview:self.secondTV];
    [(UIView *)contentArray[2] addSubview:self.threeTV];
    [(UIView *)contentArray[3] addSubview:self.fourTV];
    
    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) titleArray:topics contentViewArray:contentArray];
    [self.view addSubview:scView];
    
    scView.block = ^(int index){
        self.number = index;
        ZXTopic *topic = self.titleArray[index-1];
        int productType = [topic.product_id intValue];
        UITableView *tableView = [(UIView *)contentArray[index-1] subviews][0];
        [self requestProductListWithUrl:Product_List_Url ModelClassString:@"ZXProduct" TableView:tableView Status:productType];
    };
    
}
#pragma mark - 请求产品列表数据
- (void)requestProductListWithUrl:(NSString *)url ModelClassString:(NSString *)modelString TableView:(UITableView *)tableView Status:(int)status{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"productType"] = @(status);
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.productArray = [NSClassFromString(modelString) mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        [tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
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

#pragma mark UITextFielDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    SearchController *vc = [SearchController sharedSearchController];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}


static BOOL isCreated = YES;
#pragma mark - 左边筛选按钮对应事件
- (void)didClickFilter:(UIButton *)btn{
    NSMutableArray *sortTitles = [self requestDataByHttp:Product_SortList_Url];
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
        
        FilterBottomView *filterBottomView = [[[NSBundle mainBundle]loadNibNamed:@"FilterBottomView" owner:self options:nil] firstObject];
        [filterBottomView.cancleBtn addTarget:self action:@selector(hideShowView:) forControlEvents:UIControlEventTouchUpInside];
        [filterBottomView.confirmBtn addTarget:self action:@selector(hideShowView:) forControlEvents:UIControlEventTouchUpInside];
        
        filterBottomView.frame = CGRectMake(0,660, ScreenW, 60);
        UIColor *color = RGB(242, 242, 242, 1);
        
        filterBottomView.layer.borderColor = color.CGColor;
        filterBottomView.layer.borderWidth = 1;
        
        [scrollView addSubview:filterBottomView];
        
        scrollView.contentSize = CGSizeMake(ScreenW, 720);
        
        
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

- (NSMutableArray *)requestDataByHttp:(NSString *)url{
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *models = [NSMutableArray array];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSString *key in [responseObject[@"data"] allKeys]) {
            [titles addObject:key];
            [models addObject: [ZXSortModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"]objectForKey:key]]];
        }
        for (NSInteger i = 0; i < titles.count; i ++) {
            BlockView *block = [[BlockView alloc] initWithFrame:CGRectMake(0, 0 + i * 110, ScreenW, 110)];
            [block setupBlockViewContent:models[i] buttonBorderWidth:3 borderColor:[UIColor redColor]  title:titles[i]];
            [self.filterView addSubview:block];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    self.models = models;
    return titles;
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
        CGFloat blockH = 80;
        BlockView *block = [[BlockView alloc] initWithFrame:CGRectMake(0,0, ScreenW, blockH)];
        [block setupSortBlockContentView:[NSArray arrayWithObjects:@"默认",@"最新",@"收益",@"佣金", nil]];
        block.block = ^(int tag){
            
            ZXLog(@"tag : %d",tag);
            
        };
        
        [self.sortView addSubview:block];
        [UIView animateWithDuration:DurationTime animations:^{
            self.showSortView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0.65];}];
        [UIView animateWithDuration:DurationTime animations:^{
            self.sortView.frame = CGRectMake(0, 0, self.sortView.frame.size.width,blockH);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXProductCell *cell = [ZXProductCell cellWithTableView:tableView];
    cell.product = self.productArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    if (app.isLogin) {
        ZXProductCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        ProductDetailController *vc = [[ProductDetailController alloc] init];
        vc.title = cell.product.productTitle;
        ZXProduct *product = self.productArray[indexPath.row];
        vc.product_id = product.proId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginController *login = [[LoginController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        [kWindowRootController presentViewController:nav animated:YES completion:nil];
    }
    
}

@end
