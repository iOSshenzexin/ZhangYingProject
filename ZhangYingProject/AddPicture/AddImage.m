//
//  AddImage.m
//  1
//
//  Created by 杨晓婧 on 15/12/5.
//  Copyright © 2015年 PS. All rights reserved.
//
#import "AddImage.h"
#import "AFNetworking.h"
#import <AVFoundation/AVFoundation.h>
#define imageH 60 // 图片高度
#define imageW 60 // 图片宽度
#define kMaxColumn 4 // 每行显示数量
#define MaxImageCount 4 // 最多显示图片个数
#define deleImageWH 20 // 删除按钮的宽高
#define kAdeleImage @"cg_del.png" // 删除按钮图片
#define kAddImage @"my-add" // 添加按钮图片
//#import "SJAvatarBrowser.h"
@interface AddImage()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    //标识被编辑的按钮 -1 为添加新的按钮
    NSInteger editTag;
}
@end

@implementation AddImage

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _btn = [self createButtonWithImage:kAddImage andSeletor:@selector(addNew:)];
        [_btn sizeToFit];
        _firstArray = [NSMutableArray array];
        [self addSubview:_btn];
    }
    return self;
}

-(NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

// 添加新的控件
- (void)addNew:(UIButton *)btn{
    NSLog(@"%d",[self deleClose:btn]);
    // 标识为添加一个新的图片
    if (![self deleClose:btn]){
        editTag = -1;
//        UIImageView *img = [[UIImageView alloc] initWithFrame:btn.frame];
//        img.image = btn.currentBackgroundImage;
//        [SJAvatarBrowser showImage:img];
        [self callImagePicker];
    }
}

// 修改旧的控件
- (void)changeOld:(UIButton *)btn{
    // 标识为修改(tag为修改标识)
    UIImageView *img = [[UIImageView alloc] initWithFrame:btn.frame];
    img.image = btn.currentBackgroundImage;
   // [SJAvatarBrowser showImage:img];
//    if (![self deleClose:btn]) {
//        editTag = btn.tag;
//    
////  [self callImagePicker];
//    }
}

// 删除"删除按钮"
- (BOOL)deleClose:(UIButton *)btn{
    if (btn.subviews.count == 2) {
        [[btn.subviews lastObject] removeFromSuperview];
        [self stop:btn];
        return YES;
    }
    return NO;
}

static UIImagePickerController *picker;
// 调用图片选择器
- (void)callImagePicker{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        [self.window.rootViewController presentViewController:picker animated:YES completion:^{}];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的相机无法启动，请去打开手机系统权限!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}


// 根据图片名称或者图片创建一个新的显示控件
- (UIButton *)createButtonWithImage:(id)imageNameOrImage andSeletor : (SEL)selector{
    UIImage *addImage = nil;
    if ([imageNameOrImage isKindOfClass:[NSString class]]) {
        addImage = [UIImage imageNamed:imageNameOrImage];
    }
    else if([imageNameOrImage isKindOfClass:[UIImage class]])
    {
        addImage = imageNameOrImage;
    }
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:addImage forState:UIControlStateNormal];
    [addBtn setBackgroundImage:addImage forState:UIControlStateNormal];
    [addBtn sizeToFit];
    [addBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = self.subviews.count;
    
    // 添加长按手势,用作删除.加号按钮不添加
    if(addBtn.tag != 0)
    {
        UILongPressGestureRecognizer *gester = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [addBtn addGestureRecognizer:gester];
    }
    return addBtn;
}


// 长按添加删除按钮
- (void)longPress : (UIGestureRecognizer *)gester
{
    if (gester.state == UIGestureRecognizerStateBegan)
    {
        UIButton *btn = (UIButton *)gester.view;
        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
        dele.bounds = CGRectMake(0, 0, deleImageWH, deleImageWH);
        [dele setImage:[UIImage imageNamed:kAdeleImage] forState:UIControlStateNormal];
        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        dele.frame = CGRectMake(btn.frame.size.width - dele.frame.size.width, 0, dele.frame.size.width, dele.frame.size.height);
        [btn addSubview:dele];
        [self start : btn];
    }
}

// 长按开始抖动
- (void)start:(UIButton *)btn{
    double angle1 = -5.0 / 180.0 * M_PI;
    double angle2 = 5.0 / 180.0 * M_PI;
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle1),  @(angle2), @(angle1)];
    anim.duration = 0.25;
    // 动画的重复执行次数
    anim.repeatCount = MAXFLOAT;
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [btn.layer addAnimation:anim forKey:@"shake"];
}

// 停止抖动
- (void)stop : (UIButton *)btn{
    [btn.layer removeAnimationForKey:@"shake"];
}

// 删除图片
- (void)deletePic : (UIButton *)btn
{
    for (int i = 0; i<self.images.count; i++) {
        btn.superview.tag = 100+i;
    }
    [self.images removeObject:[(UIButton *)btn.superview imageForState:UIControlStateNormal]];
    [btn.superview removeFromSuperview];
    [self.images removeObject:[self.images objectAtIndex:(self.images.count-1-(btn.superview.tag-100))]];
    if ([[self.subviews lastObject] isHidden]) {
        [[self.subviews lastObject] setHidden:NO];
    }
    self.firstArray = [NSMutableArray arrayWithArray:self.images];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pictureNumber" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lu",(unsigned long)self.firstArray.count],@"number", nil]];
}

// 对所有子控件进行布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = (int )self.subviews.count;
    CGFloat btnW = imageW;
    CGFloat btnH = imageH;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnX = 10 + i*70;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

#pragma mark - UIImagePickerController 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (editTag == -1){
        UIButton *btn = [self createButtonWithImage:image andSeletor:@selector(changeOld:)];
        btn.tag = 100 +self.subviews.count-1;
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [self insertSubview:btn atIndex:self.subviews.count - 1];
        if (self.subviews.count - 1 == MaxImageCount) {
            [[self.subviews lastObject] setHidden:YES];
        }
    }
    else{
        UIButton *btn = (UIButton *)[self viewWithTag:editTag];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [self.images removeObjectAtIndex:btn.tag-100];
        }
   [picker dismissViewControllerAnimated:YES completion:nil];
    NSData * data = UIImageJPEGRepresentation(image, 0.5);
    NSString * str = [data base64EncodedStringWithOptions:0];
    [self.images addObject:str];
    self.firstArray = [NSMutableArray arrayWithArray:self.images];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pictureNumber" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lu",(unsigned long)self.firstArray.count],@"number", nil]];
}


@end
