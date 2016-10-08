//
//  ProductShareController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductShareController.h"

#import "ProductShareCustomSyleOneCell.h"
#import "ProductShareCustomSyleTwoCell.h"

#import "PersonInfoController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialUIManager.h"
@interface ProductShareController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy) NSString *content;

@property (nonatomic,strong) UIButton *telephoneBtn;
@end

@implementation ProductShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottomView.layer.borderWidth = 1;
    UIColor *color = RGB(216, 216, 216, 0.8);
     self.bottomView.layer.borderColor = [color CGColor];
    self.productShareTableView.sectionFooterHeight = 0;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // [self.view setNeedsDisplay];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
    titleLabel.textColor= RGB(163, 163, 163, 1);
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text= @"分享内容预览";
    [headerView addSubview:titleLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductShareCustomSyleOneCell *cell = [ProductShareCustomSyleOneCell cellWithTableView:tableView];
    cell.productTitleLbl.text = self.productTitle;
    
    [cell.editedBtn addTarget:self action:@selector(didClickedEditInfo:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectedBtn addTarget:self action:@selector(didClickSelected:) forControlEvents:UIControlEventTouchUpInside];
    cell.borderView.layer.borderWidth = 1;
    UIColor *color = RGB(216, 216, 216, 0.8);
    cell.borderView.layer.borderColor = [color CGColor];
    
    ZXLoginModel *model = AppLoginModel;
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[baseUrl stringByAppendingString:model.headPortrait]] placeholderImage:nil];
    cell.nameLbl.text = [NSString stringWithFormat:@"您的投资顾问 <%@> 分享给您的投资项目.",model.name];
    self.content = [NSString stringWithFormat:@"投资顾问 <%@> 分享给您的投资项目.点击查看详情!",model.name];
    cell.phoneLbl.text = [NSString stringWithFormat:@"%.0f",model.phone];
    return cell;
}

- (void)didClickedEditInfo:(UIButton *)btn{
    PersonInfoController *vc = [[PersonInfoController alloc] init];
    vc.title = @"个人设置";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickSelected:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.telephoneBtn = btn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}


- (IBAction)didClickShareProduct:(UIButton *)sender {
     NSArray *paltformTypeArray = [NSArray arrayWithObjects:@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Email), nil];
    
    UMSocialPlatformType platformtype= [paltformTypeArray[sender.tag -521] integerValue];
    [self shareDataWithPlatform:platformtype];
}


- (UMSocialMessageObject *)creatMessageObject
{
    ZXLoginModel *model = AppLoginModel;
    NSString *text;
    if (self.telephoneBtn.selected) {
      text = [NSString stringWithFormat:@"投资顾问 <%@> 分享给您的投资项目.点击查看详情! 联系方式:%@",model.name,[NSString stringWithFormat:@"%.0f",model.phone]];
    }else
    {
        text = self.content;
    }
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSString *title = self.productTitle;
    NSString *url = @"http://ios9quan.9quan.com.cn/www/wine/show/70488/37961/9502";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:@"http://dev.umeng.com/images/tab2_1.png"];
    [shareObject setWebpageUrl:url];
    messageObject.shareObject = shareObject;
    return messageObject;

}

//直接分享
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

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.view = nil;
}

@end
