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
#import "UIBarButtonItem+ZXItem.h"

#define DurationTime 0.35

@interface ProductController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
{
    CGFloat _lastBlockViewY;
}

@property (nonatomic,strong) NSMutableArray <__kindof ZXTopic *>*titleArray;
@property (nonatomic,strong) NSMutableArray *productArray;



@property (nonatomic,strong) UIView *showView;

@property (nonatomic,strong) UIView *showSortView;

@property (nonatomic,strong) UIScrollView *sortView;
@property (nonatomic,strong) UIScrollView *filterView;

@property (nonatomic,assign) BOOL isShow;

@property (nonatomic,copy) NSMutableArray *models;

@property (nonatomic,strong) NSMutableArray *contentArray;

@property (nonatomic,strong) LXSegmentScrollView *segmentScollView;


@property (nonatomic,assign) int sortNumber;


@property (nonatomic,assign) int pageIndex;
@end

@implementation ProductController

//**************懒加载部分********************
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

+(ProductController *)sharedProductController{
    static ProductController *vc = nil;
    if (!vc) {
        vc = [[ProductController alloc] init];
    }
    return vc;
}

- (UITableView *)createCustomTableView
{
    UITableView *customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-148)];
    customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    customTableView.dataSource = self;
    customTableView.delegate = self;
    customTableView.rowHeight = 120;
    customTableView.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
    customTableView.backgroundColor = [UIColor clearColor];
    customTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
    customTableView.mj_header.automaticallyChangeAlpha = YES;

    customTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfo)];
    return customTableView;
}



-(void)loadNewInfo
{
    [self.productArray removeAllObjects];
    self.pageIndex = 0;
    UITableView *tableView = [(UIView *)self.contentArray[self.number-1] subviews][0];
    [self requestProductListWithUrl:Product_List_Url ModelClassString:@"ZXProduct" TableView:tableView Status:self.number andSort:self.sortNumber type:0];
}

- (void)loadMoreInfo
{
    UITableView *tableView = [(UIView *)self.contentArray[self.number-1] subviews][0];
    [self requestProductListWithUrl:Product_List_Url ModelClassString:@"ZXProduct" TableView:tableView Status:self.number andSort:self.sortNumber type:1];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBarSubviews];

    self.sortNumber = 0;
    
    self.number = 1;
    
    [self loadTopicTitle];

    [ZXNotificationCeter addObserver:self selector:@selector(sort:) name:ZXSortButtonClickNotificationCeter object:nil];
    
    [ZXNotificationCeter addObserver:self selector:@selector(filter:) name:ZXFilterButtonClickNotificationCeter object:nil];
}

- (void)filter:(NSNotification *)noti
{
    NSMutableDictionary *typeDictionary = [NSMutableDictionary dictionary];
    NSString *keyString;
    for (UIView *sub in self.filterView.subviews) {
        if ([sub isKindOfClass:[BlockView class]]) {
            for (UIView *subs in sub.subviews) {
                UIButton *btn;
                if ([subs isKindOfClass:[UILabel class]]) {
                    UILabel *titleLbl = (UILabel *)subs;
                    if ([titleLbl.text isEqualToString:@"销售状态"]) {
                        keyString = @"salesStatus";
                    }else if([titleLbl.text isEqualToString:@"投资领域"]){
                        keyString = @"productField";
                    }else if([titleLbl.text isEqualToString:@"产品期限"]){
                        keyString = @"productDeadline";
                    }else if([titleLbl.text isEqualToString:@"发行方"]){
                        keyString = @"issuer";
                    }else if([titleLbl.text isEqualToString:@"起投金额"]){
                        keyString = @"initialAmount";
                    }else{
                        keyString = @"payInterest";
                    }
                }
                if ([subs isKindOfClass:[UIButton class]]){
                    btn = (UIButton *)subs;
                }
                if (btn.selected) {
                    [typeDictionary setValue:@(btn.tag) forKey:keyString];
                }
            }
        }
    }
    ZXTopic *topic = self.titleArray[self.number -1];
    [typeDictionary setValue:topic.product_id  forKey:@"productType"];
    UITableView *tableView = [(UIView *)self.contentArray[self.number -1] subviews][0];

    [self requestProductList:Product_List_Url modelClassName:@"ZXProduct" tableView:tableView dictionary:typeDictionary];
 
}
#pragma mark - 请求筛选数据列表
- (void)requestProductList:(NSString *)url modelClassName:(NSString *)model tableView:(UITableView *)tableView dictionary:(NSMutableDictionary *)typeDic
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"productType"] = typeDic[@"productType"];
    params[@"productDeadline"] = typeDic[@"productDeadline"];
    params[@"productField"] = typeDic[@"productField"];
    params[@"issuer"] = typeDic[@"issuer"];
    params[@"initialAmount"] = typeDic[@"initialAmount"];
    params[@"payInterest"] = typeDic[@"payInterest"];
    params[@"salesStatus"] = typeDic[@"salesStatus"];
    params[@"sort"] = @(self.sortNumber);
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *items = [NSClassFromString(model) mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        if (items.count == 0) {
            self.productArray = items;
            [MBProgressHUD showSuccess:@"已经是最后一页了"];
        }else{
            self.productArray = items;
        }
        [tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
    
}

- (void)sort:(NSNotification *)noti
{
    int sortNumber = [noti.userInfo[@"KEY"] intValue]-1;
    if (sortNumber > 0) {
        self.sortNumber = sortNumber;
        ZXTopic *topic = self.titleArray[self.number -1];
        int productType = [topic.product_id intValue];
        UITableView *tableView = [(UIView *)self.contentArray[self.number -1] subviews][0];
        [tableView.mj_header beginRefreshing];
        [self requestProductListWithUrl:Product_List_Url ModelClassString:@"ZXProduct" TableView:tableView Status:productType andSort:self.sortNumber type:0];
    }
}



#pragma mark - 加载头部视图的网络数据
- (void)loadTopicTitle
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:Product_Topic_Url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.titleArray = [ZXTopic mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self setupTopSegment];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){ZXError}];
}

- (void)getProductListInfomation:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    self.number = [dic[@"index"] intValue];
}

#pragma mark - 创建头部视图
- (void)setupTopSegment{
    self.automaticallyAdjustsScrollViewInsets = NO; //iOS7新增属性
    self.contentArray = [NSMutableArray array];
    NSMutableArray *topics= [NSMutableArray array];
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        UIView *view= [[UIView alloc] init];
        ZXTopic *topic = self.titleArray[i];
        [topics addObject:topic.typeName];
        view.backgroundColor = RGB(242, 242, 242, 1);
        [view addSubview:[self createCustomTableView]];
        [self.contentArray addObject:view];
    }
    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) titleArray:topics contentViewArray:self.contentArray];
    self.segmentScollView = scView;
    [self.view addSubview:self.segmentScollView];
    
    UITableView *tableView = [(UIView *)self.contentArray[self.number-1] subviews][0];
    [tableView.mj_header beginRefreshing];
    
    scView.block = ^(int index){
        self.number = index;
        ZXTopic *topic = self.titleArray[index-1];
        self.number = [topic.product_id intValue];
        UITableView *tableView = [(UIView *)self.contentArray[index-1] subviews][0];
        [tableView.mj_header beginRefreshing];
    };
}

#pragma mark - 请求产品列表数据
- (void)requestProductListWithUrl:(NSString *)url ModelClassString:(NSString *)modelString TableView:(UITableView *)tableView Status:(int)status andSort:(int)sort type:(NSInteger)type{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"productType"] = @(status);
    params[@"pageIndex"] = @(self.pageIndex);
    params[@"sort"] = @(self.sortNumber);
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      NSMutableArray *items = [NSClassFromString(modelString) mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        if (type == 0) {
            self.productArray = items;
        }else{
            if (items.count == 0) {
                [MBProgressHUD showSuccess:@"已经是最后一页了"];
            }else{
                [self.productArray addObjectsFromArray:items];
        }
        }
        self.pageIndex ++;
        [tableView reloadData];
        [tableView.mj_header endRefreshing];
        [tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}

- (void)setupNavigationBarSubviews{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithFont:16 title:@"筛选" target:self action:@selector(didClickFilter:) edgeInset:25];
                                            
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithFont:16 title:@"排序" target:self action:@selector(didClickSort:) edgeInset:-25];
    UITextField *searchText = [ZXSearchBar searchBar];
    searchText.frame = CGRectMake(0, 0, ScreenW, 32);
    self.navigationItem.titleView = searchText;
    searchText.placeholder = @"请输入您要搜索的产品";
    searchText.delegate = self;
}

#pragma mark UITextFielDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    SearchController *vc = [[SearchController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}

static BOOL isCreated = YES;
#pragma mark - 左边筛选按钮对应事件
- (void)didClickFilter:(UIButton *)btn{
    [self requestDataByHttp:Product_SortList_Url];
    [self openSortlist];
}

- (void)openSortlist{
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
        ZXResponseObject
        for (NSString *key in [responseObject[@"data"] allKeys]) {
            [titles addObject:key];
            [models addObject: [ZXSortModel mj_objectArrayWithKeyValuesArray:[responseObject[@"data"]objectForKey:key]]];
        }
        CGFloat sum = 0;
        for (NSInteger i = 0; i < titles.count; i ++) {
            BlockView *block = [[BlockView alloc] init];
            CGFloat Y = [block setupBlockViewContent:models[i] buttonBorderWidth:3 borderColor:[UIColor redColor]  title:titles[i]];
            block.frame = CGRectMake(0, sum, ScreenW, Y);
            sum += Y;
            if (i == titles.count -1) {
                _lastBlockViewY = sum;
            }
            [self.filterView addSubview:block];
        }
        FilterBottomView *filterBottomView = [[[NSBundle mainBundle]loadNibNamed:@"FilterBottomView" owner:self options:nil] firstObject];
        [filterBottomView.cancleBtn addTarget:self action:@selector(hideShowView:) forControlEvents:UIControlEventTouchUpInside];
        [filterBottomView.confirmBtn addTarget:self action:@selector(hideShowView:) forControlEvents:UIControlEventTouchUpInside];
         [filterBottomView.removeBtn addTarget:self action:@selector(removeSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.filterView addSubview:filterBottomView];
        filterBottomView.frame = CGRectMake(0,_lastBlockViewY, ScreenW, 60);
        self.filterView .contentSize = CGSizeMake(ScreenW, _lastBlockViewY + 60);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       ZXError
    }];
    self.models = models;
    return titles;
}

- (void)removeSelectButton:(UIButton *)btn
{
    for (UIView *sub in self.filterView.subviews) {
        if ([sub isKindOfClass:[BlockView class]]) {
            for (UIView *subs in sub.subviews) {
                if ([subs isKindOfClass:[UIButton class]]){
                    UIButton *btn = (UIButton *)subs;
                    btn.backgroundColor =[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]  ;
                    [btn setTitleColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] forState:UIControlStateNormal];
                }
            }
        }
    }
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
    if (btn.tag == 42) {
        [ZXNotificationCeter postNotificationName:ZXFilterButtonClickNotificationCeter object:nil userInfo:@{@"KEY":@(btn.tag)}];
    }
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
        CGFloat blockH = 60;
        BlockView *block = [[BlockView alloc] initWithFrame:CGRectMake(0,0, ScreenW, blockH)];
        [block setupSortBlockContentView:[NSArray arrayWithObjects:@"默认",@"最新",@"收益",@"佣金", nil]];
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

-(void)dealloc{
    [ZXNotificationCeter removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.showView) {
        isCreated = !isCreated;
        [self.filterView removeFromSuperview];
        [self.showView removeFromSuperview];
    }
    if (self.showSortView) {
        [self.showSortView removeFromSuperview];
    }
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //self.productArray = nil;
    //self.view = nil;
}
@end
