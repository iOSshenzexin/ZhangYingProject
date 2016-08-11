//
//  ProductController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductController.h"
#import "SecondView.h"
#import "TrustCustomCell.h"
#import "ZXSearchBar.h"
#import "SearchController.h"
#import "ProductDetailController.h"

#import "FilterBottomView.h"
#import "BlockView.h"
#define DurationTime 0.35

@interface ProductController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak,nonatomic) UITextField *textField;

@property (nonatomic,copy) NSArray *titleArray;
/** 信托 */
@property (nonatomic,strong) UITableView *trustTableView;

@property (nonatomic,strong) UIView *showView;
@property (nonatomic,strong) UIView *showSortView;

@property (nonatomic,strong) UIScrollView *sortView;
@property (nonatomic,strong) UIScrollView *filterView;

@end

@implementation ProductController

//-(void)viewWilllAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if(!appDlg.isReachable){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry,您当前网络连接异常!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
//
//}

 static NSString *str = @"cellId";
-(UITableView *)trustTableView{
    if (!_trustTableView) {
        _trustTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-148)];
        _trustTableView.dataSource = self;
        _trustTableView.delegate = self;
        _trustTableView.rowHeight = 120;
        [_trustTableView registerNib:[UINib nibWithNibName:@"TrustCustomCell" bundle:nil] forCellReuseIdentifier:str];
        _trustTableView.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
        _trustTableView.backgroundColor = [UIColor clearColor];
    }
    return _trustTableView;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"信托",@"资管",@"阳光私募",@"其他",@"股票", @"信托",nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [ZXSearchBar searchBar];
    UITextField *txt = (UITextField *)self.navigationItem.titleView;
    txt.placeholder = @"这里有你适合的...";
    txt.delegate = self;
    self.textField = txt;
    [self setupTopSegment];
    [self setupNavigationBarBtn];
    [self deleteBack];
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}

#pragma mark UITextFielDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pictureNumber" object:nil userInfo:nil];
    self.hidesBottomBarWhenPushed = YES;
    SearchController *vc = [SearchController sharedSearchController];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    return NO;
}

- (void)setupNavigationBarBtn{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 60, 30);
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [leftBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(didClickFilter:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [rightBtn setTitle:@"排序" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(didClickSort:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}


#pragma mark       左边筛选按钮对应事件
- (void)didClickFilter:(UIButton *)btn{
    static BOOL isCreated = YES;
    UIApplication *app = [UIApplication sharedApplication];
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

#pragma mark      右边排序按钮对应事件
- (void)didClickSort:(UIButton *)btn{
    static BOOL isCreated = YES;
    UIApplication *app = [UIApplication sharedApplication];
    if (isCreated) {
        UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0,64, ScreenW, ScreenH-64)];
        self.showSortView = showView;
        
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
    }else{
        [UIView animateWithDuration:DurationTime animations:^{
            self.sortView.frame = CGRectMake(0, 0, self.sortView.frame.size.width, 0);
        }completion:^(BOOL finished) {
            self.showSortView.backgroundColor = [UIColor colorWithRed:0.145 green:0.145 blue:0.145 alpha:0];
            [self.showSortView removeFromSuperview];
        }];
    }
    isCreated = !isCreated;
}

- (void)setupTopSegment{
    self.automaticallyAdjustsScrollViewInsets= NO; //iOS7新增属性
    NSMutableArray *contentArray= [NSMutableArray array];
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        UIView *view= [[UIView alloc] init];
        view.backgroundColor = RGB(242, 242, 242, 1);
        [contentArray addObject:view];
    }
    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) titleArray:self.titleArray contentViewArray:contentArray];
    [self.view addSubview:scView];
    
    //信托
    UIView *view = (UIView *)contentArray[0];
    [view addSubview:self.trustTableView];
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
    UIColor *color = RGB(216, 216, 216, 0.8);
    cell.layer.borderColor = [color CGColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    TrustCustomCell *cell = [self.trustTableView cellForRowAtIndexPath:indexPath];
    ProductDetailController *vc = [[ProductDetailController alloc] init];
    vc.title = cell.titleLbl.text;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
@end
