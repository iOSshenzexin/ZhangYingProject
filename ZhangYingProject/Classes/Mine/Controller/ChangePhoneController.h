//
//  ChangePhoneController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePhoneController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtField;
- (IBAction)modifyPhoneNumber:(id)sender;

@end