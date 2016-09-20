//
//  MyCollectionController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/11.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyCollectionController.h"
#import "CustomCollectionStyleOneCell.h"
#import "CustomCollectionStyleTwoCell.h"

@interface MyCollectionController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSArray *titleArray;

@property (nonatomic,strong) UITableView *firstTableView;
@property (nonatomic,strong) UITableView *secondTableView;


@property (nonatomic,strong) NSMutableArray *rowsArray;
@property (nonatomic,strong) NSMutableArray *rowsSecondArray;


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

static NSString *secondStr = @"twoCellId";
-(UITableView *)secondTableView{
    if (!_secondTableView) {
        _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH -64)];
        _secondTableView.dataSource = self;
        _secondTableView.delegate = self;
        _secondTableView.rowHeight = 120;
        [_secondTableView registerNib:[UINib nibWithNibName:@"CustomCollectionStyleTwoCell" bundle:nil] forCellReuseIdentifier:secondStr];
        _secondTableView.contentInset = UIEdgeInsetsMake(0, 0, 108, 0);
        _secondTableView.backgroundColor = [UIColor clearColor];
        _secondTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        }
    return _secondTableView;
}


-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"在售产品",@"历史产品",nil];
    }
    return _titleArray;
}

-(NSMutableArray *)rowsSecondArray{
    if (!_rowsSecondArray) {
        _rowsSecondArray = [NSMutableArray arrayWithObjects:@"在售产品",@"历史产品",@"在售产品",@"历史产品",@"在售产品",@"历史产品",nil];
    }
    return _rowsSecondArray;
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
    [secondView addSubview:self.secondTableView];
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,self.secondTableView.frame.size.height - 104, ScreenW, 60)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.borderWidth = 0.5;
    UIColor *color = RGB(204, 204, 204, 1);
    bottomView.layer.borderColor = color.CGColor;
    
    [secondView addSubview:bottomView];
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(ScreenW - 115, 10, 100, 40);
    clearBtn.layer.cornerRadius = 3;
    [clearBtn setTitle:@"全部清除" forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(didClickRemoveCell:) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.backgroundColor = [UIColor redColor];
    [bottomView addSubview:clearBtn];
}

- (void)didClickRemoveCell:(UIButton *)btn{
    [self.rowsSecondArray removeAllObjects];
    [self.secondTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.secondTableView) {
        return self.rowsSecondArray.count;
    }
    return self.rowsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.firstTableView) {
        CustomCollectionStyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[CustomCollectionStyleOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        CustomCollectionStyleTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:secondStr];
        if (!cell) {
            cell = [[CustomCollectionStyleTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondStr];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.borderWidth = 6;
        UIColor *color = RGB(242, 242, 242, 1);
        cell.layer.borderColor = [color CGColor];
        return cell;
    }
    return nil;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
     return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (tableView == self.firstTableView) {
            [self.rowsArray removeObjectAtIndex:indexPath.row];
            [self.firstTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.firstTableView reloadData];
        }else{
            [self.rowsSecondArray removeObjectAtIndex:indexPath.row];
            [self.secondTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.secondTableView reloadData];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
