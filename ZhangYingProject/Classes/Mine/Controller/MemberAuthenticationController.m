//
//  MemberAuthenticationController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/21.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MemberAuthenticationController.h"
#import "CustomLine.h"
@interface MemberAuthenticationController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
}
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (weak, nonatomic) IBOutlet UITextField *nameTxt;

@property (weak, nonatomic) IBOutlet UITextField *memberIDTxt;

@property (nonatomic,copy) NSString *base64String;


@end

@implementation MemberAuthenticationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView.layer.borderWidth = 1;
    UIColor *color = RGB(204, 204, 204, 0.8);
    self.backgroundView.layer.borderColor = [color CGColor];
    CustomLine *line = [[CustomLine alloc] init];
    line.frame = CGRectMake(15, self.backgroundView.bounds.size.height * 0.5, self.backgroundView.bounds.size.width -30, 1);
    line.backgroundColor = RGB(242/255.0, 242/255.0, 242/255.0, 0.3);
    [self.backgroundView addSubview:line];
    [self setupTxtFieldAndImage];
}

- (void)setupTxtFieldAndImage{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, self.nameTxt.frame.size.height)];
    UILabel *leftLbl = [[UILabel alloc] init];
    leftLbl.bounds = CGRectMake(0, 10, 80, self.nameTxt.frame.size.height);
    leftLbl.font = [UIFont systemFontOfSize:14];
    leftLbl.text = @"真实姓名";
    leftLbl.center = leftView.center;
    [leftView addSubview:leftLbl];
    self.nameTxt.leftView = leftView;
    self.nameTxt.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *memberView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, self.memberIDTxt.frame.size.height)];
    UILabel *memberLbl = [[UILabel alloc] init];
    memberLbl.bounds = CGRectMake(0, 10, 80, self.nameTxt.frame.size.height);
    memberLbl.font = [UIFont systemFontOfSize:14];

    memberLbl.text = @"身份证号";
    memberLbl.center = leftView.center;
    [memberView addSubview:memberLbl];
    self.memberIDTxt.leftView = memberView;
    self.memberIDTxt.leftViewMode = UITextFieldViewModeAlways;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)didClickSubmitAuthentication:(id)sender {
    if (self.nameTxt.text.length == 0) {
        [MBProgressHUD showError:@"真实姓名的长度不合要求!"];
    }else if (self.memberIDTxt.text.length != 18) {
            [MBProgressHUD showError:@"身份证号的长度不合要求!"];
    }else if(![ZXVerificationObject validateIdentityCard:self.memberIDTxt.text]){
            [MBProgressHUD showError:@"身份证号的格式不合要求!"];
    }else{
        [self submitAuthentication];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)submitAuthentication
{
    [MBProgressHUD showMessage:@"正在提交认证....." toView:self.view];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"mid"] = model.mid;
    params[@"regName"] = self.nameTxt.text;
    params[@"cardNumber"] = self.memberIDTxt.text;
    params[@"businessCard"] = self.base64String;
    [manager POST:Product_MemberAuthentication_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if([responseObject[@"status"] intValue] == 1){
            [MBProgressHUD showSuccess:@"认证成功!"];
        }else{
            [MBProgressHUD showError:@"认证有误,请重试!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"认证失败,请检查网络!"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        ZXError
    }];
}

- (IBAction)didClickPicture:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.pictureButton setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:^{
        self.base64String = [UIImagePNGRepresentation(self.pictureButton.currentImage) base64EncodedStringWithOptions:0];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}
@end
