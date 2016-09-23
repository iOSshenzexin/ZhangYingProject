//
//  ProductRequirementController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/1.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductRequirementController.h"

#import "CustomAlertView.h"
@interface ProductRequirementController ()

@end

@implementation ProductRequirementController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.placeholder = @"请把你的产品需求告诉我们,稍后我们会以电话的方式跟你联系.";
    self.textView.placeholderTextColor = [UIColor grayColor];
    ZXLoginModel *model = AppLoginModel;
    self.titleLbl.attributedText = [UILabel labelWithRichNumber:[NSString stringWithFormat:@"请确认 %.0f 能联系到您",model.phone] Color:[UIColor redColor] FontSize:16];
}

/**弹窗动画*/
- (void)animationAlert:(UIView *)view{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
}

- (IBAction)didClickChangePhoneNumber:(id)sender {
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0.5;
    shadowView.tag = 102;
    [self.view addSubview:shadowView];
    
    CustomAlertView *alerView = [[[NSBundle mainBundle]loadNibNamed:@"CustomAlertView" owner:self options:nil] firstObject];
    alerView.tag = 103;
    alerView.frame = CGRectMake((ScreenW - 300) * 0.5, (ScreenH - 178) *0.3, 300, 178);
    [alerView.cancleBtn addTarget:self action:@selector(didClickCancleBtn:) forControlEvents:UIControlEventTouchUpInside];
     [alerView.confirmBtn addTarget:self action:@selector(didClickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    alerView.layer.cornerRadius = 8;
    alerView.layer.masksToBounds = YES;
    [self.view addSubview:alerView];
    [self animationAlert:alerView];
}

- (void)didClickCancleBtn:(UIButton *)btn{
    [(UIView *)[self.view viewWithTag:102] removeFromSuperview];
    [(UIView *)[self.view viewWithTag:103] removeFromSuperview];
}

- (void)didClickConfirmBtn:(UIButton *)btn{
    CustomAlertView *alerView = (CustomAlertView *)[self.view viewWithTag:103];
    NSString *str = [NSString stringWithFormat:@"请确认 %@ 能联系到您",alerView.numberTxt.text];
    if((alerView.numberTxt.text.length != 11) | (![ZXVerificationObject validateMobile:alerView.numberTxt.text])){
        [MBProgressHUD showError:@"手机号码输入有误!"];
    }
    else{
        self.titleLbl.attributedText = [UILabel labelWithRichNumber:str Color:[UIColor redColor] FontSize:16];
        [(UIView *)[self.view viewWithTag:102] removeFromSuperview];
        [(UIView *)[self.view viewWithTag:103] removeFromSuperview];
   }
}


- (IBAction)didClickSubmitRequirement:(id)sender {
    NSString *phone = [[self.titleLbl.text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = @1;
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    params[@"demandDetail"] = self.textView.text;
    params[@"phone"] = phone;
    [manager POST:Deal_ProductRequirement_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"status"] intValue] == 1){
            [MBProgressHUD showSuccess:@"提交成功!"];
        }else{
            [MBProgressHUD showError:@"提交失败,请稍后重试!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误,请稍后重试!"];
        ZXError
    }];
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
