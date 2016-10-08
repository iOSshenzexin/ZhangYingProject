//
//  BlockView.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/10.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "BlockView.h"

#import "ZXSortModel.h"
#define btnTitleColor      [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1]

#define btnBackgroundColor [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]

@interface BlockView ()

@property (nonatomic,strong) UIButton *propertyBtn;

@property (nonatomic,strong) UIButton *previousBtn;

@property (nonatomic,assign) CGFloat lastBtnY;

@end

@implementation BlockView

-(CGFloat)setupBlockViewContent:(NSArray *)titleArray buttonBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor title:(NSString *)title{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 4, 16)];
    imageView.image = [UIImage imageNamed:@"pro1"];
    [self addSubview:imageView];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 16)];
    titleLbl.font = [UIFont systemFontOfSize:14];
    titleLbl.text = title;
    [self addSubview:titleLbl];
    
    CGFloat btnW = (ScreenW - 50) * 0.25;
    for (NSInteger i = 0; i < titleArray.count ; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + i % 4 *(btnW + 10), 36 + (i / 4) * 40, btnW, 30);
        ZXSortModel *model = titleArray[i];
        [btn setTitle:model.title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(didClickFilterProduct:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = [model.sortId intValue];;
        btn.layer.cornerRadius = 3;
        btn.layer.borderWidth = 0.5;
        UIColor *color = RGB(227, 227, 227, 1);
        btn.layer.borderColor = color.CGColor;
        if (i == 0) {
            [self didClickSortProduct:btn];
        }else{
            btn.backgroundColor = btnBackgroundColor;
            [btn setTitleColor:btnTitleColor forState:UIControlStateNormal];
        }
        if (i == titleArray.count - 1) {
            self.lastBtnY = CGRectGetMaxY(btn.frame);
        }
        [self addSubview:btn];
    }
    return self.lastBtnY + 5;
}


- (void)didClick:(UIButton *)btn{
    static BOOL isSelected = YES;
    if (btn != self.propertyBtn) {
        self.propertyBtn = btn;
        isSelected = !self.propertyBtn.selected;
    }
    if (isSelected) {
        btn.backgroundColor = [UIColor redColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        btn.backgroundColor = btnBackgroundColor;
        [btn setTitleColor:btnTitleColor forState:UIControlStateNormal];
    }
    btn.selected = isSelected;
    isSelected = !isSelected;
}


-(void)setupSortBlockContentView:(NSArray *)titleArray{
    NSInteger count = titleArray.count;
    CGFloat btnW = (ScreenW - 50) * 0.25;
    for (NSInteger i = 0; i < count ; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + i % 4 *(btnW + 10),10 + (i / 4) * 40, btnW, 30);
        btn.tag = i +1;
        if (i == 0) {
            [self didClickSortProduct:btn];
        }else{
            btn.backgroundColor = btnBackgroundColor;
            [btn setTitleColor:btnTitleColor forState:UIControlStateNormal];
        }
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(didClickSortProduct:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 3;
        btn.layer.borderWidth = 0.5;
        UIColor *color = RGB(227, 227, 227, 1);
        btn.layer.borderColor = [color CGColor];
        [self addSubview:btn];
    }
}

- (void)didClickSortProduct:(UIButton *)btn
{
    if (self.previousBtn != btn) {
        btn.selected = YES;
        self.previousBtn.selected = NO;
        [ZXNotificationCeter postNotificationName:ZXSortButtonClickNotificationCeter object:nil userInfo:@{@"KEY":@(btn.tag)}];
    }else{
       // btn.selected = !btn.selected;
    }
    if (btn.selected) {
        btn.backgroundColor = [UIColor redColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        btn.backgroundColor = btnBackgroundColor;
        [btn setTitleColor:btnTitleColor forState:UIControlStateNormal];
    }
    if (self.previousBtn.selected) {
         self.previousBtn.backgroundColor = [UIColor redColor];
        [self.previousBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.previousBtn.backgroundColor = btnBackgroundColor;
        [self.previousBtn setTitleColor:btnTitleColor forState:UIControlStateNormal];
    }
    self.previousBtn = btn;
}


- (void)didClickFilterProduct:(UIButton *)btn
{
    if (self.previousBtn != btn) {
        btn.selected = YES;
        self.previousBtn.selected = NO;
    }else{
        // btn.selected = !btn.selected;
    }
    if (btn.selected) {
        ZXLog(@"selected btn.tag %zd",btn.tag);
        btn.backgroundColor = [UIColor redColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        btn.backgroundColor = btnBackgroundColor;
        [btn setTitleColor:btnTitleColor forState:UIControlStateNormal];
    }
    if (self.previousBtn.selected) {
        self.previousBtn.backgroundColor = [UIColor redColor];
        [self.previousBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.previousBtn.backgroundColor = btnBackgroundColor;
        [self.previousBtn setTitleColor:btnTitleColor forState:UIControlStateNormal];
    }
    self.previousBtn = btn;
}


@end
