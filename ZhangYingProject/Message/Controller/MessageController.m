//
//  MessageController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MessageController.h"
#import "MessageCustomCell.h"

#import "MessageDetailController.h"
@interface MessageController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSArray *imgArray;
@property (nonatomic,copy) NSArray *titleArray;
@property (nonatomic,copy) NSArray *subtitleArray;
@property (nonatomic,copy) NSArray *timeArray;

@end

@implementation MessageController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(!appDlg.isReachable){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry,您当前网络连接异常!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

-(NSArray *)imgArray{
    if (!_imgArray) {
        _imgArray = [NSArray arrayWithObjects:@"message01",@"message02",@"message04",@"message03",@"message02",@"message04", nil];
    }
    return _imgArray;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"信托公司-投资者的信赖",@"新浪网新闻中心",@"新华社石家庄7月25日",@"搜狐视频新闻频道",@"百度新闻是包含海量资讯",@"青岛新闻网拥有在网民", nil];
    }
    return _titleArray;
}

-(NSArray *)subtitleArray{
    if (!_subtitleArray) {
        _subtitleArray = [NSArray arrayWithObjects:@"对于信托公司风控能力如何,不管是投资者还是...",@"新浪网新闻中心是新浪网最重要的频道之一,24小时滚动报道国内、国际及社会新闻",@"新华社石家庄7月25日电题:40年前唐山大地震新闻人物今安在 新华社记者李俊义、任丽颖、",@"搜狐视频新闻频道是中文互联网成立最早,最权威的视频新闻门户,为用户提供最新最全面的时",@"百度新闻是包含海量资讯的新闻服务平台,真实反映每时每刻的新闻热点。",@"青岛新闻网拥有在网民中具有高度影响力和号召力的门户论坛社区青青岛。网站下设青岛新闻、微博,青岛房产,青岛汽车,", nil];
    }
    return _subtitleArray;
}

-(NSArray *)timeArray{
    if (!_timeArray) {
        _timeArray = [NSArray arrayWithObjects:@"2016-7-25",@"今天",@"2016-7-25",@"2016-7-25",@"2016-7-25",@"昨天", nil];
    }
    return _timeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    self.messageTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self deleteBack];
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
}

static NSString *cellID = @"cellID";
- (void)registerCell{
    [self.messageTableView registerNib:[UINib nibWithNibName:@"MessageCustomCell" bundle:nil] forCellReuseIdentifier:cellID];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.timeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MessageCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIColor *color = RGB(242, 242, 242, 1);
    cell.layer.borderColor = [color CGColor];
    cell.layer.borderWidth = 2;
    cell.img.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
    cell.titleLbl.text = self.titleArray[indexPath.row];
    cell.timeLbl.text = self.timeArray[indexPath.row];
    cell.subTitleLbl.text = self.subtitleArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    MessageDetailController *vc = [[MessageDetailController alloc] init];
    MessageCustomCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    vc.title = cell.titleLbl.text;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}


@end
