//
//  MineController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didClickEnterMyWallet:(id)sender;

- (IBAction)didClickEnterMyCard:(id)sender;

@end
