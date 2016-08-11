//
//  MyCollectionController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/11.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyCollectionController.h"
#import "CustomCollectionStyleOneCell.h"
@interface MyCollectionController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSArray *titleArray;

@property (nonatomic,strong) UITableView *firstTableView;


@property (nonatomic,strong) NSMutableArray *rowsArray;

@end

@implementation MyCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopSegment];
}

static NSString *str = @"cellId";
-(UITableView *)firstTableView{
    if (!_firstTableView) {
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH -64)];
        _firstTableView.dataSource = self;
        _firstTableView.delegate = self;
        _firstTableView.rowHeight = 120;
        [_firstTableView registerNib:[UINib nibWithNibName:@"CustomCollectionStyleOneCell" bundle:nil] forCellReuseIdentifier:str];
        _firstTableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        _firstTableView.backgroundColor = [UIColor clearColor];
        _firstTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _firstTableView;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"在售产品",@"历史产品",nil];
    }
    return _titleArray;
}

-(NSMutableArray *)rowsArray{
    if (!_rowsArray) {
        _rowsArray = [NSMutableArray arrayWithObjects:@"在售产品",@"历史产品",@"在售产品",@"历史产品",@"在售产品",@"历史产品",nil];
    }
    return _rowsArray;
}



- (void)setupTopSegment{
    self.automaticallyAdjustsScrollViewInsets= NO; //iOS7新增属性
    NSMutableArray *contentArray= [NSMutableArray array];
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        UIView *view= [[UIView alloc] init];
        view.backgroundColor = RGB(242, 242, 242, 1);
        [contentArray addObject:view];
    }
    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) titleArray:self.titleArray contentViewArray:contentArray];
    [self.view addSubview:scView];
    
    UIView *view = (UIView *)contentArray[0];
    [view addSubview:self.firstTableView];
    
    UIView *secondView = (UIView *)contentArray[1];
    [secondView addSubview:self.firstTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionStyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CustomCollectionStyleOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
     return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.rowsArray removeObjectAtIndex:indexPath.row];
        [self.firstTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.firstTableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
