//
//  MyBillController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/26.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyBillController.h"

@interface MyBillController ()
@property (nonatomic,copy) NSArray *titleArray;
@end

@implementation MyBillController

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"入账记录",@"提现记录", nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopSegment];
}

- (void)setupTopSegment{
    self.automaticallyAdjustsScrollViewInsets=NO; //iOS7新增属性
    NSMutableArray *contentArray= [NSMutableArray array];
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        UIView *view=[[UIView alloc] initWithFrame:self.view.frame];
        view.backgroundColor = RGB(242, 242, 242, 1);
        [contentArray addObject:view];
    }
    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) titleArray:self.titleArray contentViewArray:contentArray];
    [self.view addSubview:scView];
}

@end
