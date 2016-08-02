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
@interface ProductController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak,nonatomic) UITextField *textField;

@property (nonatomic,copy) NSArray *titleArray;
/** 信托 */
@property (nonatomic,strong) UITableView *trustTableView;
@end

@implementation ProductController

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

#pragma mark 筛选
- (void)didClickFilter:(UIButton *)btn{
    NSLog(@"筛选");
}

#pragma mark 排序
- (void)didClickSort:(UIButton *)btn{
    NSLog(@"排序");
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
