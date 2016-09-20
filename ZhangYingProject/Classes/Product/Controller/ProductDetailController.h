//
//  ProductDetailController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailController : UIViewController

@property (nonatomic,copy) NSString *product_id;

@property (weak, nonatomic) IBOutlet UITableView *productDetailTableview;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
- (IBAction)didClickCollecting:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collectedBtn;

@end
