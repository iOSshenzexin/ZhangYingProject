//
//  BlockView.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/10.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "BlockView.h"

#define btnTitleColor         [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1]

#define btnBackgroundColor [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]



@interface BlockView ()

@property (nonatomic,strong) UIButton *propertyBtn;

@end

@implementation BlockView

-(void)setupBlockViewContent:(NSArray *)titleArray buttonBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor title:(NSString *)title{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 4, 16)];
    imageView.image = [UIImage imageNamed:@"pro1"];
    [self addSubview:imageView];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 16)];
    titleLbl.text = title;
    [self addSubview:titleLbl];
    
    NSInteger count = titleArray.count;
    CGFloat btnW = (ScreenW - 50) * 0.25;
    for (NSInteger i = 0; i < count ; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + i % 4 *(btnW + 10), 36 + (i / 4) * 50, btnW, 40);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 3;
        btn.layer.borderWidth = 0.5;
        UIColor *color = RGB(227, 227, 227, 1);
        btn.layer.borderColor = [color CGColor];
        if (i == 0) {
            btn.selected = YES;
            btn.backgroundColor = [UIColor redColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            btn.backgroundColor = btnBackgroundColor;
            [btn setTitleColor:btnTitleColor forState:UIControlStateNormal];
        }
        [self addSubview:btn];
    }
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
        btn.frame = CGRectMake(10 + i % 4 *(btnW + 10),10 + (i / 4) * 50, btnW, 40);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:btnTitleColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 3;
        btn.layer.borderWidth = 0.5;
        UIColor *color = RGB(227, 227, 227, 1);
        btn.layer.borderColor = [color CGColor];
        btn.backgroundColor = btnBackgroundColor;
        [self addSubview:btn];
    }
}
@end
