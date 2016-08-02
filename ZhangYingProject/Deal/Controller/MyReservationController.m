//
//  MyReservationController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/28.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyReservationController.h"

#import "CustomOrderCell.h"
@interface MyReservationController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *titleArray;
/**预约成功表格*/
@property (nonatomic,strong) UITableView *firstTableView;
/**待确认*/
@property (nonatomic,strong) UITableView *secondTableView;
/**预约失败*/
@property (nonatomic,strong) UITableView *thirdTableView;

@end

@implementation MyReservationController

static NSString *str = @"cellId";
-(UITableView *)firstTableView{
    if (!_firstTableView) {
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-148)];
        _firstTableView.dataSource = self;
        _firstTableView.delegate = self;
        _firstTableView.rowHeight = 80;
        [_firstTableView registerNib:[UINib nibWithNibName:@"CustomOrderCell" bundle:nil] forCellReuseIdentifier:str];
        _firstTableView.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
        _firstTableView.backgroundColor = [UIColor clearColor];
        _firstTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _firstTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopSegment];
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"预约成功",@"待确认",@"预约失败",nil];
    }
    return _titleArray;
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
}


#pragma mark UITableViewDelegate And UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CustomOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.subTitleLbl.attributedText = [self getAttributedString:cell.subTitleLbl.text];
    cell.layer.borderWidth = 3;
    UIColor *color = RGB(242, 242, 242, 1);
    cell.layer.borderColor = [color CGColor];
    return cell;
}



- (NSAttributedString *)getAttributedString:(NSString *)string{
    NSMutableAttributedString *mabString = [[NSMutableAttributedString alloc] initWithString:string];
    [mabString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8, 3)];
    [mabString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(8, 3)];
    
    [mabString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(27, 5)];
    [mabString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(27, 5)];
    
    return mabString;
}
@end
