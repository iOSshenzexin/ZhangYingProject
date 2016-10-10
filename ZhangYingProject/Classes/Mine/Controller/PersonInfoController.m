//
//  PersonInfoController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "PersonInfoController.h"
#import "ZXCircleHeadImage.h"
#import "ChangePhoneController.h"
#import "CustomPersonCell.h"

#import "ModifyPhoneController.h"
#import "IQKeyboardManager.h"
#import "UIButton+WebCache.h"
@interface PersonInfoController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,ModifyPhoneControllerDelegate,UIPickerViewDelegate>
{
    NSArray *_sexArray;
}

//@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;

@property (nonatomic,copy) NSArray *imgArray;
@property (nonatomic,copy) NSArray *nameArray;

@property (nonatomic,copy) NSArray *txtPlaceHolder;

@property (nonatomic,assign) NSInteger row;

@property (nonatomic,copy) ZXLoginModel *loginModel;

- (IBAction)handOffHeadImage:(id)sender;


@end

@implementation PersonInfoController

+(PersonInfoController *)sharedPersonController{
    static PersonInfoController *vc = nil;
    if (!vc) {
        vc = [[PersonInfoController alloc] init];
    }
    return vc;
}

-(NSArray *)imgArray{
    if (!_imgArray) {
        _imgArray = [NSArray arrayWithObjects:@"my-data01",@"my-data02",@"my-data03",@"my-data04", nil];
    }
    return _imgArray;
}

-(NSArray *)nameArray{
    if (!_nameArray) {
        _nameArray = [NSArray arrayWithObjects:@"姓名",@"称谓",@"邮箱",@"电话", nil];
    }
    return _nameArray;
}


-(NSArray *)txtPlaceHolder{
    if (!_txtPlaceHolder) {
        _txtPlaceHolder = [NSArray arrayWithObjects:@"您的真实姓名",@"请填写您的称谓",@"您的电子邮箱地址", nil];
    }
    return _txtPlaceHolder;
}

static NSString *str = @"cellId";
- (void)viewDidLoad {
    [super viewDidLoad];
    ZXLoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:loginModel]];
    self.loginModel = model;
    //设置头像
    [self.headImageBtn  sd_setImageWithURL:[NSURL URLWithString:[baseUrl stringByAppendingString:model.headPortrait]] forState:UIControlStateNormal placeholderImage:[ZXCircleHeadImage clipImageForHeadImage:[UIImage imageNamed:@"my-phone"] andBorderWidth:2 borderColor:[UIColor redColor]]];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
    
    ModifyPhoneController *vc = [ModifyPhoneController sharedModifyPhoneController];
    vc.delegate = self;
    
    _sexArray = @[@"先生",@"女士"];
//    //添加键盘IQKeyboardReturnKeyHandler
//    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
//    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
}

//- (void)dealloc
//{
//    self.returnKeyHandler = nil;
//}


- (void)bindingPhoneNumber:(ModifyPhoneController *)vc{
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:0];
    CustomPersonCell *cell = [self.tableView cellForRowAtIndexPath:path];
    cell.txtField.text = vc.NumberTxt.text;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomPersonCell *cell = [CustomPersonCell cellWithTableView:tableView];
    cell.img.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
    cell.nameLbl.text = self.nameArray[indexPath.row];
//     (indexPath.row == 3) ? (cell.changeNumberBtn.hidden = NO) : (cell.changeNumberBtn.hidden = YES);
    if(indexPath.row != 3){
        [cell.changeNumberBtn removeFromSuperview];
    }
    if (indexPath.row != 3) {
        if (indexPath.row == 0) {
            cell.txtField.text = self.loginModel.name;
        }else if(indexPath.row == 1){
            cell.txtField.text = self.loginModel.nickname;
        }else{
            cell.txtField.text = [NSString stringWithFormat:@"%@",self.loginModel.email];
        }
        cell.txtField.placeholder = self.txtPlaceHolder[indexPath.row];
    }else{
        cell.txtField.text = [NSString stringWithFormat:@"%.0f",self.loginModel.phone];
        cell.txtField.enabled = NO;
        [cell.changeNumberBtn addTarget:self action:@selector(changPhoneNumber:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (indexPath.row == 1) {
        cell.txtField.inputView = [self createInputView];
    }
    return cell;
}

- (UIView *)createInputView
{
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    int count = 2;
    NSArray *titles = @[@"取消",@"确定"];
    for (int i = 0; i< count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + (ScreenW -80) *i, 4, 60, 30);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(didClickSelectSex:) forControlEvents:UIControlEventTouchUpInside];
        [inputView addSubview:btn];
    }
    UIPickerView *pickView = [[UIPickerView alloc] init];
    pickView.frame = CGRectMake(0, 60, ScreenW, 80);
    [pickView selectRow:1 inComponent:0 animated:NO];
    [inputView addSubview:pickView];
    pickView.delegate = self;
    return  inputView;
}

- (void)didClickSelectSex:(UIButton *)btn
{
    if (btn.tag == 2) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
        CustomPersonCell *cell = [self.tableView cellForRowAtIndexPath:index];
        cell.txtField.text = _sexArray[self.row];
    }
    [self.view endEditing:YES];
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _sexArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
    CustomPersonCell *cell = [self.tableView cellForRowAtIndexPath:index];
    self.row = row;
    cell.txtField.text = _sexArray[row];
}

- (void)changPhoneNumber:(UIButton *)btn{
    ChangePhoneController *vc = [[ChangePhoneController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"更换绑定手机";
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (IBAction)handOffHeadImage:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
    cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil];
     actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

#pragma mark ActionSheetDelegate
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
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    LECropPictureViewController *cropPictureController = [[LECropPictureViewController alloc] initWithImage:image andCropPictureType:LECropPictureTypeRounded];
    cropPictureController.view.backgroundColor = [UIColor blackColor];
    cropPictureController.cropFrame = CGRectMake(ScreenW * 0.5 - 75, ScreenH * 0.5 -75, 150, 150);
    cropPictureController.borderColor = [UIColor grayColor];
    cropPictureController.borderWidth = 1.0;
   
    cropPictureController.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cropPictureController.photoAcceptedBlock = ^(UIImage *croppedPicture){
        UIImage *img = [ZXCircleHeadImage clipOriginImage:croppedPicture scaleToSize:self.headImageBtn.frame.size borderWidth: 2 borderColor: [UIColor redColor]];
        self.headImage = img;

        [self.headImageBtn setImage:img forState:UIControlStateNormal];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:cropPictureController animated:YES completion:nil];
    
}

- (void)uploadHeadImage{

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.tableView resignFirstResponder];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view endEditing:YES];
}

- (IBAction)didClickConfirmChange:(id)sender {
    [MBProgressHUD showMessage:@"正在提交修改..." toView:self.view];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    CustomPersonCell *cellName = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    params[@"name"] = cellName.txtField.text;
    CustomPersonCell *cellNickName = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    params[@"nickname"] = cellNickName.txtField.text;
    CustomPersonCell *cellEmail = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
     CustomPersonCell *cellPhone = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    params[@"email"] = cellEmail.txtField.text;
    params[@"headPortrait"] = [UIImagePNGRepresentation(self.headImageBtn.currentImage) base64EncodedStringWithOptions:0];
    ZXLoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:loginModel]];
     params[@"mid"] = model.mid;
    [manager POST:Product_MemberInfoChange_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        if([responseObject[@"status"] intValue] == 1){
            [MBProgressHUD showSuccess:@"修改成功!"];
            self.userName = cellPhone.txtField.text;
            //修改model  
            [model setValue:cellName.txtField.text forKey:@"name"];
            [model setValue:cellNickName.txtField.text forKey:@"nickname"];
            [model setValue:cellEmail.txtField.text forKey:@"email"];
            [model setValue:responseObject[@"data"] forKey:@"headPortrait"];
            [StandardUser setObject:[NSKeyedArchiver archivedDataWithRootObject:model] forKey:loginModel];
            [StandardUser synchronize];            
            if ([self.delegate respondsToSelector:@selector(setupUserHeadImage:)]) {
                [self.delegate setupUserHeadImage:self];
            }
        }else{
            [MBProgressHUD showError:@"修改失败,请重试!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"修改失败,请检查网络!"];
        ZXError
    }];
}



@end
