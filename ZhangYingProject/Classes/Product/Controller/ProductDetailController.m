//
//  ProductDetailController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/27.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ProductDetailController.h"

#import "ProductShareController.h"

#import "ProductDetailStyleOneCustomCell.h"
#import "ProductDetailStyleTwoCustomCell.h"
#import "ProductDetailStyleThreeCustomCell.h"
#import "ProductDetailStyleFourCustomCell.h"
#import "ProductReservationController.h"

#import "ZXPop.h"
#import "ZXWindowiew.h"
#import "ZXProuctDetailModel.h"

#import "LoginController.h"
@interface ProductDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *titleArray;


@property (nonatomic,strong) ZXProuctDetailModel *detailModel;

@end

@implementation ProductDetailController

- (IBAction)didClickShowProductShare:(id)sender {
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    //判断是否登录
    if (app.isLogin) {
        ProductShareController *vc = [[ProductShareController alloc] init];
        vc.title = @"产品分享";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginController *login = [[LoginController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        [kWindowRootController presentViewController:nav animated:YES completion:nil];
    }
}

- (IBAction)didClickProductReservation:(id)sender {
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    //判断是否登录
    if (app.isLogin) {
        ProductReservationController *vc = [[ProductReservationController alloc] init];
        vc.title = @"预约";
        vc.productName = self.title;
        vc.product_id = self.product_id;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginController *login = [[LoginController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        [kWindowRootController presentViewController:nav animated:YES completion:nil];
    }
    
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"募集账号",@"资金用途",@"还款来源",@"融资方介绍",@"风控措施", @"项目亮点",@"产品附件",nil];
    }
    return _titleArray;
}

static NSString *styleDefault = @"styleDefault";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottomImageView.layer.borderWidth = 1;
    UIColor *color = RGB(216, 216, 216, 0.8);
    self.bottomImageView.layer.borderColor = [color CGColor];
    /** 加载产品详情数据 */
    [self loadInternetData];
}

#pragma mark - 加载产品详情数据 
- (void)loadInternetData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pid"] = self.product_id;
    [manager POST:Product_Detail_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        ZXResponseObject
       self.detailModel = [ZXProuctDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self.productDetailTableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXLog(@"%@",error);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ProductDetailStyleOneCustomCell *cell = [ProductDetailStyleOneCustomCell cellWithTableView:tableView];
        cell.productDetail = self.detailModel;
        return cell;
    }
    if (indexPath.row == 1) {
        ProductDetailStyleTwoCustomCell *cell = [ProductDetailStyleTwoCustomCell cellWithTableView:tableView];
        cell.detailModel = self.detailModel;
        return cell;
    }
    if (indexPath.row == 2) {
        ProductDetailStyleThreeCustomCell *cell = [ProductDetailStyleThreeCustomCell cellWithTableView:tableView];
        cell.detailModel = self.detailModel;
        return cell;
    }
    if (indexPath.row == 3) {
        ProductDetailStyleFourCustomCell *cell = [ProductDetailStyleFourCustomCell cellWithTableView:tableView];
        cell.detailModel = self.detailModel;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:styleDefault];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:styleDefault];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titleArray[indexPath.row - 4];
    cell.imageView.image = [UIImage imageNamed:@"pro2-details05"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 | indexPath.row == 1) {
        return 180;
    }
    if (indexPath.row == 2) {
        return 270;
    }
    if (indexPath.row == 3) {
        return 115;
    }
    return 44;
}

- (IBAction)didClickCollecting:(id)sender {
    AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
    //判断是否登录
    if (app.isLogin) {
        self.collectedBtn.selected = !self.collectedBtn.selected;
        (self.collectedBtn.selected)?([MBProgressHUD showSuccess:@"收藏成功!"]):([MBProgressHUD showSuccess:@"收藏取消!"]);
        [self addFavorite];
    }else{
        LoginController *login = [[LoginController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        [kWindowRootController presentViewController:nav animated:YES completion:nil];
    }
    
}

/**
 *  添加关注
 */
- (void)addFavorite
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"productId"] = self.product_id;
    ZXLoginModel *model = AppLoginModel;
    params[@"memberId"] = model.mid;
    [manager POST:Product_AddFavorite_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZXResponseObject
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 3){
    ZXPop *popView = [[ZXPop alloc] init];
    [popView addPopWithView:self.view];
    ZXWindowiew *window = (ZXWindowiew *)popView.mainView;
    [window.cancleBtn addTarget:self action:@selector(didClickCancle:) forControlEvents:UIControlEventTouchUpInside];
        switch (indexPath.row) {
            case 4:
                window.contentTxt.text = self.detailModel.raiseAccount;
                window.titleLabel.text = @"募集账号";
                break;
            case 5:
                window.contentTxt.text = self.detailModel.earmarking;
                window.titleLabel.text = @"资金用途";
                break;
            case 6:
                window.contentTxt.text = self.detailModel.payment;
                window.titleLabel.text = @"还款来源";
                break;
            case 7:
                window.contentTxt.text = self.detailModel.financing;
                window.titleLabel.text = @"融资方介绍";
                break;
            case 8:
                window.contentTxt.text = self.detailModel.measures;
                window.titleLabel.text = @"风控措施";
                break;
            case 9:
                window.contentTxt.text = self.detailModel.project;
                window.titleLabel.text = @"项目亮点";
                break;
            case 10:
                window.contentTxt.text = self.detailModel.enclosure;
                window.titleLabel.text = @"产品附件";
                break;
            default:
                break;
        }
    }
}

- (void)didClickCancle:(UIButton *)btn{
    [btn.superview removeFromSuperview];
    [[self.view viewWithTag:102] removeFromSuperview];
}


@end
