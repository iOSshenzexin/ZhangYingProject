//
//  MineController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MineController.h"
#import "ZXCircleHeadImage.h"
#import "PersonInfoController.h"
@interface MineController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *dataSource;
@property (nonatomic,copy) NSArray *imageArray;
- (IBAction)didClickSetPersonInfo:(id)sender;

@end

@implementation MineController

-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray arrayWithObjects:@"交易设置",@"安全设置",@"关于我们",@"呼叫客服", nil];
    }
    return _dataSource;
}

-(NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSArray arrayWithObjects:@"my-icon01",@"my-icon02",@"my-icon03",@"my-icon04", nil];
    }
    return _imageArray;
}

  //设置个人信息
- (IBAction)didClickSetPersonInfo:(id)sender {
    PersonInfoController *vc = [[PersonInfoController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    vc.title = @"个人资料";
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headImage.image = [ZXCircleHeadImage clipOriginImage:[UIImage imageNamed:@"my-phone"] scaleToSize:self.headImage.frame.size borderWidth:4 borderColor:[UIColor redColor]];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
    self.tableView.sectionFooterHeight = 0;
    [self deleteBack];
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text = self.dataSource[indexPath.row];
    if (indexPath.row == 3) {
        cell.detailTextLabel.text = @"400-666-8888";
        cell.detailTextLabel.textColor = [UIColor redColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeServiceCall:)];
        cell.detailTextLabel.userInteractionEnabled = YES;
        [cell.detailTextLabel addGestureRecognizer:tap];
    }
    return cell;
}

- (void)makeServiceCall:(UITapGestureRecognizer *)tap{
    UIWebView *callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel://400-666-8888"];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
//    NSString *allString = [NSString stringWithFormat:@"tel:10086"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
}

@end
