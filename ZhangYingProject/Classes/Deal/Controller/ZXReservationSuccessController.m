//
//  ZXReservationSuccessController.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXReservationSuccessController.h"

@interface ZXReservationSuccessController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ZXReservationSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productTitle.text = self.reservationModel.proTitle;
    self.useName.text = [NSString stringWithFormat:@"客户姓名: %@",self.reservationModel.userName];
    self.memberId.text = [NSString stringWithFormat:@"客户身份证号: %@",self.reservationModel.memberId];
    self.payDate.text = [NSString stringWithFormat:@"预计打款日期: %@",self.reservationModel.payTimeStr];
    self.payAccount.text = [NSString stringWithFormat:@"预计打款金额: %@万",self.reservationModel.payAmount];
    
    self.telephone.text = [NSString stringWithFormat:@"联系方式: %@",self.reservationModel.phone];
    
    self.address.text = [NSString stringWithFormat:@"收货地址: %@",self.reservationModel.address];

}

- (IBAction)didClickUploadImage:(UIButton *)btn {
    btn.selected = YES;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    if (buttonIndex == 2) return;
    if (buttonIndex == 0) {
        //调用相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"您的照相机不可用或被您禁用了!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
    if (buttonIndex == 1){
        //调用相册
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        for (UIView *subview in self.bottomView.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)subview;
                if (btn.isSelected) {
                    [btn setImage:image forState:UIControlStateNormal];
                    btn.selected = NO;
                }
            }
        }
    }];
}

- (IBAction)didClickUplaodProofIno:(id)sender {
    [MBProgressHUD showMessage:@"正在上传...." toView:self.view];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.reservationModel.reserver_id;
    for (UIView *subview in self.bottomView.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subview;
            if (btn.tag == 11) {
                params[@"certificateImage"] = [UIImagePNGRepresentation(btn.currentImage) base64EncodedStringWithOptions:0];}
            if (btn.tag == 12) {
                params[@"cardpImage"] = [UIImagePNGRepresentation(btn.currentImage) base64EncodedStringWithOptions:0];}
            if (btn.tag == 13) {
                params[@"bankCard"] = [UIImagePNGRepresentation(btn.currentImage) base64EncodedStringWithOptions:0];}
        }
    }
    [mgr POST:Deal_UploadProofInfo_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZXResponseObject
        [MBProgressHUD hideHUDForView:self.view];
        if([responseObject[@"status"] intValue] == 1){
            [MBProgressHUD showSuccess:@"提交凭证成功!"];
        }else{
            [MBProgressHUD showError:@"提交凭证失败,请重试!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        ZXError
        [MBProgressHUD showError:@"网络错误,请重试!"];
    }];
    
}
    
@end
