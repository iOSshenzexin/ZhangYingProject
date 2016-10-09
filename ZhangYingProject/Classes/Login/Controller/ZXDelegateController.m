//
//  ZXDelegateController.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/10/9.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXDelegateController.h"

@interface ZXDelegateController ()

@end

@implementation ZXDelegateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)didClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
