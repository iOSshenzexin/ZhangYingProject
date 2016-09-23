//
//  ProductRequirementController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXTextView.h"
@interface ProductRequirementController : UIViewController
- (IBAction)didClickChangePhoneNumber:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet ZXTextView *textView;

@end
