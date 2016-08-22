//
//  ProductReservationController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductReservationController.h"

#import "DeliveryAddressController.h"

@interface ProductReservationController ()<UITextFieldDelegate>{
    NSInteger prewTag ;  //编辑上一个UITextField的TAG,需要在XIB文件中定义或者程序中添加，不能让两个控件的TAG相同
    float prewMoveY;
}

@end

@implementation ProductReservationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountTxt.delegate = self;
}

- (IBAction)didClickChangeAddress:(id)sender {
    DeliveryAddressController *vc = [[DeliveryAddressController alloc] init];
    vc.title = @"修改收货地址";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    int offset =  216.0  ;//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0){
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    [self.accountTxt resignFirstResponder];
    
    return NO;
}
@end
