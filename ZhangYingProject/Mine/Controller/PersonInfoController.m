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

@interface PersonInfoController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,ModifyPhoneControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *headImageBtn;

@property (nonatomic,copy) NSArray *imgArray;
@property (nonatomic,copy) NSArray *nameArray;
@property (nonatomic,copy) NSArray *txtPlaceHolder;


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
    [self.headImageBtn setImage: [ZXCircleHeadImage clipImageForHeadImage:[UIImage imageNamed:@"my-phone"] andBorderWidth:5 borderColor:[UIColor redColor]] forState:UIControlStateNormal];
    UINib *nib = [UINib nibWithNibName:@"CustomPersonCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:str];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
    
    ModifyPhoneController *vc = [ModifyPhoneController sharedModifyPhoneController];
    vc.delegate = self;
}

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
    CustomPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[CustomPersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.img.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
    cell.nameLbl.text = self.nameArray[indexPath.row];
     (indexPath.row == 3) ? (cell.changeNumberBtn.hidden = NO) : (cell.changeNumberBtn.hidden = YES);
    if (indexPath.row != 3) {
        cell.txtField.placeholder = self.txtPlaceHolder[indexPath.row];
    }else{
        cell.txtField.text = @"15198765234";
        cell.txtField.enabled = NO;
        [cell.changeNumberBtn addTarget:self action:@selector(changPhoneNumber:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)changPhoneNumber:(UIButton *)btn{
    ChangePhoneController *vc = [[ChangePhoneController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    vc.title = @"更换绑定手机";
    [self.navigationController pushViewController:vc animated:YES];
    //self.hidesBottomBarWhenPushed = NO;
    [self deleteBack];
}

- (void)deleteBack{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
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
        UIImage *img = [ZXCircleHeadImage clipOriginImage:croppedPicture scaleToSize:self.headImageBtn.frame.size borderWidth: 5 borderColor: [UIColor redColor] ];
        [self.headImageBtn setImage:img forState:UIControlStateNormal];
        self.headImage = img;
        if ([self.delegate respondsToSelector:@selector(setupUserHeadImage:)]) {
            [self.delegate setupUserHeadImage:self];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:cropPictureController animated:YES completion:nil];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.tableView resignFirstResponder];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
