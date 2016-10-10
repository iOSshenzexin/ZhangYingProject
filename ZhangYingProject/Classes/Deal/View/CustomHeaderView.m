//
//  CustomHeaderView.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/12.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "CustomHeaderView.h"

@interface CustomHeaderView()

@property (nonatomic,weak) UIButton *btn;

@end

@implementation CustomHeaderView


+(instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *headerId = @"headerID";
//    CustomHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
//    if (headerView == nil) {
//        headerView = [[CustomHeaderView alloc] initWithReuseIdentifier:headerId];
//    }
    CustomHeaderView *headerView = [[CustomHeaderView alloc] initWithReuseIdentifier:headerId];
    headerView.contentView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //添加子控件
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.imageView.contentMode = UIViewContentModeCenter;
        btn.imageView.clipsToBounds = NO;
        [self.contentView addSubview:btn];
        self.btn = btn;
    }
    return self;
 }


-(void)setModel:(ShareModel *)model{
    _model = model;
    [self.btn setTitle:model.ymdTime forState:UIControlStateNormal];
    [self.btn setImage:[UIImage imageNamed:@"my-right"] forState:UIControlStateNormal];
}

- (void)didClickBtn:(UIButton *)btn{
    self.model.opened = !self.model.isOpened;
    if ([self.delegate respondsToSelector:@selector(didClickOpenHeaderVeiw:)]) {
        [self.delegate didClickOpenHeaderVeiw:self];
    }
}

-(void)layoutSubviews{
    //一定要写这句,不然会有很多不知道的错误
    [super layoutSubviews];
    CGFloat X = 10;
    CGFloat Y = 0;
    CGFloat W = self.bounds.size.width - 20;
    CGFloat H = self.bounds.size.height;
    self.btn.frame = CGRectMake(X, Y, W, H);
    self.btn.imageEdgeInsets = UIEdgeInsetsMake(0, W - 30, 0, 0);
}


-(void)didMoveToSuperview{
    if (self.model.isOpened) {
        self.btn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.btn.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}
@end
