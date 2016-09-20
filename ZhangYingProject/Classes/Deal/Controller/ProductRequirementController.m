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
//    NSMutableAttributedString *mabString = [[NSMutableAttributedString alloc] initWithString:self.titleLbl.text];
//    [mabString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 11)];
    self.titleLbl.attributedText = [self getAttributedString:self.titleLbl.text];
}
/**富文本*/
- (NSAttributedString *)getAttributedString:(NSString *)string{
    NSMutableAttributedString *mabString = [[NSMutableAttributedString alloc] initWithString:string];
    [mabString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 11)];
    return mabString;
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
    if (alerView.numberTxt.text.length == 0) {
        
    }else{
        self.titleLbl.attributedText = [self getAttributedString:str];
    }
    [(UIView *)[self.view viewWithTag:102] removeFromSuperview];
    [(UIView *)[self.view viewWithTag:103] removeFromSuperview];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
