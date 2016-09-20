//
//  ModifyPhoneController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModifyPhoneController;
@protocol ModifyPhoneControllerDelegate <NSObject>

@optional
- (void)bindingPhoneNumber:(ModifyPhoneController *)vc;


@end
@interface ModifyPhoneController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *NumberTxt;

@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTxt;

@property (weak,nonatomic) id <ModifyPhoneControllerDelegate>delegate;

+ (ModifyPhoneController *)sharedModifyPhoneController;
@end
