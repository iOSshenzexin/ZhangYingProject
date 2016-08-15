//
//  ShareDetailController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ShareDetailController.h"
#import "ProductShareCustomSyleTwoCell.h"
#import "CustomHeaderView.h"
#import "CustomShareStyleOneCell.h"

#import "ShareModel.h"
@interface ShareDetailController ()<UITableViewDelegate,UITableViewDataSource,CustomHeaderViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation ShareDetailController

static NSString *styleTwo = @"styleTwo";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        ShareModel *model = [[ShareModel alloc] init];
        model.array = [NSArray arrayWithObjects:@"2",@"3",nil];
        model.title = [NSString stringWithFormat:@"2016-08-0%ld",i];
        [self.dataArray addObject:model];
    }
    [self setupNavigationBarBtn];
    
    self.shareDetailTableView.tableHeaderView = [self createHeaderView];
    
    self.shareDetailTableView.sectionFooterHeight = 0;
    
    [self.shareDetailTableView registerNib:[UINib nibWithNibName:@"CustomShareStyleOneCell" bundle:nil] forCellReuseIdentifier:styleTwo];
}

- (UIView *)createHeaderView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    headView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 40)];
    titleLabel.textColor= RGB(163, 163, 163, 1);
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text= @"这一项目的分享记录";
    [headView addSubview:titleLabel];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CustomHeaderView *headerView = [CustomHeaderView headerViewWithTableView:tableView];
    headerView.delegate = self;
    headerView.model = self.dataArray[section];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ShareModel *model = self.dataArray[section];
    return (model.isOpened ? model.array.count:0);
}

-(void)didClickOpenHeaderVeiw:(CustomHeaderView *)headerView{
    [self.shareDetailTableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomShareStyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:styleTwo forIndexPath:indexPath];
    if (!cell) {
        cell = [[CustomShareStyleOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:styleTwo];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)setupNavigationBarBtn{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [rightBtn setTitle:@"再次分享" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(didClickMoreShare:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)didClickMoreShare:(UIButton *)btn{
    
}
@end
