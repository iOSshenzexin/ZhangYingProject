//
//  ProductShareController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/4.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductShareController.h"

#import "ProductShareCustomSyleOneCell.h"
#import "ProductShareCustomSyleTwoCell.h"
@interface ProductShareController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ProductShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottomView.layer.borderWidth = 1;
    UIColor *color = RGB(216, 216, 216, 0.8);
     self.bottomView.layer.borderColor = [color CGColor];
    [self registerTableViewCustomCell];
}

static NSString *styleOne = @"styleOne";
static NSString *styleTwo = @"styleTwo";
- (void)registerTableViewCustomCell{
    [self.productShareTableView registerNib:[UINib nibWithNibName:@"ProductShareCustomSyleOneCell" bundle:nil] forCellReuseIdentifier:styleOne];
    [self.productShareTableView registerNib:[UINib nibWithNibName:@"ProductShareCustomSyleTwoCell" bundle:nil] forCellReuseIdentifier:styleTwo];
    self.productShareTableView.sectionFooterHeight = 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
    titleLabel.textColor= RGB(163, 163, 163, 1);
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.backgroundColor = [UIColor clearColor];
    if (section == 0) {
        titleLabel.text= @"分享内容预览";
    }else{
        titleLabel.text= @"这一项目的分享记录";
    }
    [headerView addSubview:titleLabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ProductShareCustomSyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:styleOne];
        if (!cell) {
            cell = [[ProductShareCustomSyleOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:styleOne];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.borderView.layer.borderWidth = 1;
        UIColor *color = RGB(216, 216, 216, 0.8);
        cell.borderView.layer.borderColor = [color CGColor];
        return cell;
    }
    if (indexPath.section == 1) {
        ProductShareCustomSyleTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:styleTwo];
        if (!cell) {
            cell = [[ProductShareCustomSyleTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:styleTwo];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.borderView.layer.borderWidth = 1;
        UIColor *color = RGB(216, 216, 216, 0.8);
        cell.borderView.layer.borderColor = [color CGColor];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)return 170;
    return 70;
}

@end
