//
//  AboutUsController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/25.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "AboutUsController.h"

#import "ZYDelegateController.h"
@interface AboutUsController ()

@end

@implementation AboutUsController

- (IBAction)didClickPaste:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = sender.titleLabel.text;
    [MBProgressHUD showSuccess:@"已复制到剪贴板"];
}



- (IBAction)didClickShowZYDelegate:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    ZYDelegateController *vc = [[ZYDelegateController alloc] init];
    vc.title = @"掌盈用户服务协议";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aboutUsTableVeiw.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.aboutUsTableVeiw.sectionHeaderHeight = 0;
    self.aboutUsTableVeiw.sectionFooterHeight = 15;
}

- (IBAction)didClickDialTelephone:(id)sender {
    UIWebView *callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel://400-666-8888"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 4;
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 150;
    }
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 3) {
        ZXFunc
    }
}


@end
