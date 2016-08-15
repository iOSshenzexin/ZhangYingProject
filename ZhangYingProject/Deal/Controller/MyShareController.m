//
//  MyShareController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MyShareController.h"

#import "CustomShareCell.h"
#import "ShareDetailController.h"

@interface MyShareController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *firstTableView;
@property (nonatomic,strong) NSMutableArray *rowsArray;

@end

@implementation MyShareController

-(NSMutableArray *)rowsArray{
    if (!_rowsArray) {
        _rowsArray = [NSMutableArray arrayWithObjects:@"在售产品",@"历史产品",@"在售产品",@"历史产品",@"在售产品",@"历史产品",nil];
    }
    return _rowsArray;
}

  static NSString *str = @"cellId";
-(UITableView *)firstTableView{
    if (!_firstTableView) {
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _firstTableView.dataSource = self;
        _firstTableView.delegate = self;
        _firstTableView.rowHeight = 80;
        [_firstTableView registerNib:[UINib nibWithNibName:@"CustomShareCell" bundle:nil] forCellReuseIdentifier:str];
        _firstTableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _firstTableView.backgroundColor = [UIColor clearColor];
        _firstTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _firstTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.firstTableView];
    [self deleteBack];
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        CustomShareCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[CustomShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      cell.layer.borderWidth = 6;
      UIColor *color = RGB(242, 242, 242, 1);
      cell.layer.borderColor = [color CGColor];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    ShareDetailController *vc = [[ShareDetailController alloc] init];
    vc.title = @"分享详情";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
