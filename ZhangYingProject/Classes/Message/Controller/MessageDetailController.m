//
//  MessageDetailController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/25.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MessageDetailController.h"

@interface MessageDetailController ()

@end

@implementation MessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets= NO; //iOS7新增属性
    self.scrollView.autoresizesSubviews = NO;
    [self requestMessageData];
}

/**
 *{
 data =     {
 conImg = "E:\\workspace_camelot\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\palmWin\\jpg1474688018192.jpg";
 content = yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy;
 id = 5;
 introduce = yyyyyyyyyyyyyyyyyyyyyyyyyyy;
 listImg = "E:\\workspace_camelot\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\palmWin\\jpg1474688018175.jpg";
 sTime =         {
 date = 24;
 day = 6;
 hours = 0;
 minutes = 0;
 month = 8;
 seconds = 0;
 time = 1474646400000;
 timezoneOffset = "-480";
 year = 116;
 };
 title = ttttttttttyy;
 };
 msg = "\U67e5\U770b\U6d88\U606f\U8be6\U60c5\U6210\U529f";
 status = 1;
 token = "";
 }
 */

- (void)requestMessageData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.message_id;
    [mgr POST:Message_MessageDetail_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        self.titleLbl.text = dic[@"title"];
        self.contentTxt.text = dic[@"content"];
        [self.contentImg sd_setImageWithURL:[NSURL URLWithString:[baseUrl stringByAppendingString:dic[@"conImg"]]] placeholderImage:[UIImage imageNamed:@"message-banner"]];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        self.timeLbl.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dic[@"sTime"][@"time"] doubleValue]/1000.0]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}

@end
