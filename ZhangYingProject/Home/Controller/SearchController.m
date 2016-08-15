//
//  SearchController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/22.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "SearchController.h"

#import "HomeController.h"
@interface SearchController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource>{
    UISearchBar *_searchBar;
    UISearchDisplayController *searchDisplayController;
    NSMutableArray *suggestResults;
}

@property (nonatomic,strong) UISearchBar *searchBarTop;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPicNumber:) name:@"pictureNumber" object:nil];
    //隐藏掉当前页的返回按钮
    self.navigationItem.hidesBackButton = YES;
    [self initSearchBarAndMysearchDisPlay];

    //添加右侧返回按钮
    [self setupRightBarBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    [_searchBar becomeFirstResponder];
}

- (void)getPicNumber:(NSNotification *)notification{
    NSLog(@"first");
    [_searchBarTop becomeFirstResponder];
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
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.translucent = YES; //是否半透明
    [_searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    _searchBar.placeholder = @"请输入您要搜索的产品";
    [_searchBar sizeToFit];
    
    self.searchBarTop = _searchBar;

    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    
    searchDisplayController.delegate = self;
    
    //mySearchDisplayController.searchResultsDataSource = self;
    
  //  mySearchDisplayController.searchResultsDelegate = self;
    
    suggestResults = [NSMutableArray arrayWithArray:@[@"此处为推荐词", @"也可以为历史记录"]];
    self.navigationItem.titleView = _searchBar;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.searchBarTop becomeFirstResponder];

    NSLog(@"xxxxxxx");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [_searchBar resignFirstResponder];
}
@end
