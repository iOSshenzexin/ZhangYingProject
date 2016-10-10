//
//  SearchController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "SearchController.h"

#import "HomeController.h"

#import "ZXProduct.h"
#import "ZXProductCell.h"

@interface SearchController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource,HomeControllerDelegate>{
    UISearchBar *_searchBar;
    UISearchDisplayController *searchDisplayController;
    NSMutableArray *suggestResults;
}

@property (nonatomic,strong) UISearchBar *searchBarTop;

@property (nonatomic,copy) NSMutableArray *dataArray;
@end

@implementation SearchController

+ (SearchController *)sharedSearchController{
    static SearchController *vc = nil;
    if (!vc) {
        vc = [[SearchController alloc] init];
    }
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏掉当前页的返回按钮
    self.navigationItem.hidesBackButton = YES;
    [self initSearchBarAndMysearchDisPlay];
    //添加右侧返回按钮
    [self setupRightBarBtn];
}

- (void)setupRightBarBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 30);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)didClickBack:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initSearchBarAndMysearchDisPlay{
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    //设置选项
    _searchBar.barTintColor = [UIColor redColor];
    _searchBar.tintColor = [UIColor grayColor];
    _searchBar.searchBarStyle = UISearchBarStyleProminent;
    _searchBar.translucent = NO; //是否半透明
    [_searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    _searchBar.placeholder = @"请输入您要搜索的产品";
    [_searchBar sizeToFit];
    [_searchBar becomeFirstResponder];
    
    self.searchBarTop = _searchBar;

    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    
    searchDisplayController.delegate = self;
    
    //mySearchDisplayController.searchResultsDataSource = self;
    
  //  mySearchDisplayController.searchResultsDelegate = self;
    
    suggestResults = [NSMutableArray arrayWithArray:@[@"此处为推荐词", @"也可以为历史记录"]];
    self.navigationItem.titleView = _searchBar;
}

-(void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    ZXFunc
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self requestSearchData:searchBar.text];
    ZXFunc
}

- (void)requestSearchData:(NSString *)content
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"productTitle"] = content;
    [manager POST:Home_SearchProduct_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZXResponseObject
        self.dataArray = [ZXProduct mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"datas"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXProductCell *cell = [ZXProductCell cellWithTableView:tableView];
    cell.product = self.dataArray[indexPath.row];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.searchBarTop becomeFirstResponder];
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}




-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [_searchBar resignFirstResponder];
}

@end
