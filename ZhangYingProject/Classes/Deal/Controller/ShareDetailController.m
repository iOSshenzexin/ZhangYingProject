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
#import "UMSocialUIManager.h"

@interface ShareDetailController ()<UITableViewDelegate,UITableViewDataSource,CustomHeaderViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,copy) NSMutableArray *sectionTitles;


@end

@implementation ShareDetailController

static NSString *styleTwo = @"styleTwo";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestShareListDetailData];

    [self setupNavigationBarBtn];
    
    self.shareDetailTableView.tableHeaderView = [self createHeaderView];
    
    self.shareDetailTableView.sectionFooterHeight = 0;
    
    [self.shareDetailTableView registerNib:[UINib nibWithNibName:@"CustomShareStyleOneCell" bundle:nil] forCellReuseIdentifier:styleTwo];
}

- (void)requestShareListDetailData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    params[@"productId"] = self.product_id;
    [manager POST:Deal_SharedListDetail_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArray = [ShareModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.shareDetailTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
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
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ShareModel *model = self.dataArray[section];
    return (model.isOpened ? model.datas.count:0);
}

-(void)didClickOpenHeaderVeiw:(CustomHeaderView *)headerView{
    [self.shareDetailTableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShareModel *model = self.dataArray[indexPath.section];
    CustomShareStyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:styleTwo forIndexPath:indexPath];
    if (!cell) {
        cell = [[CustomShareStyleOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:styleTwo];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;

    cell.timeLbl.text = [NSString stringWithFormat:@"%@ 分享",model.datas[indexPath.row][@"createTime"]];
    if ([model.datas[indexPath.row][@"browseCount"] integerValue] > 0) {
        cell.readOrNoLbl.text = [NSString stringWithFormat:@"已读(%@次阅读)",model.datas[indexPath.row][@"browseCount"] ];
    }else
    {
        cell.readOrNoLbl.text = @"未读";
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}


- (void)setupNavigationBarBtn{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 40);
   // rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [rightBtn setTitle:@"再次分享" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(didClickMoreShare:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)didClickMoreShare:(UIButton *)btn{
    __weak typeof(self) weakSelf = self;
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInView:nil sharePlatformSelectionBlock:^(UMSocialShareSelectionView *shareSelectionView, NSIndexPath *indexPath, UMSocialPlatformType platformType) {
      //  [weakSelf disMissShareMenuView];
        [weakSelf shareDataWithPlatform:platformType];
    }];
}


- (void)shareDataWithPlatform:(UMSocialPlatformType)platformType{
    UMSocialMessageObject *messageObject = [self creatMessageObject];
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
            [self recordShare];
        }
        else{
            if (error) {
                message = [NSString stringWithFormat:@"分享失败"];
                // message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            }
            else{
                message = [NSString stringWithFormat:@"分享失败"];
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示:"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}


- (UMSocialMessageObject *)creatMessageObject
{
    ZXLoginModel *model = AppLoginModel;
    NSString *text;
//    if (self.telephoneBtn.selected) {
        text = [NSString stringWithFormat:@"理财投资顾问 <%@> 分享给您的投资项目.点击查看详情! 联系方式:%@",model.name,[NSString stringWithFormat:@"%.0f",model.phone]];
//    }else
//    {
//        text = self.content;
//    }
//    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSString *title = self.productTitle;
    NSString *url = @"http://ios9quan.9quan.com.cn/www/wine/show/70488/37961/9502";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:@"http://dev.umeng.com/images/tab2_1.png"];
    [shareObject setWebpageUrl:url];
    messageObject.shareObject = shareObject;
    return messageObject;
    
}


- (void)recordShare{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"productId"] = self.product_id;
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    [manager POST:Product_AddShared_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZXResponseObject
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
@end
