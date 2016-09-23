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
    /** 加载网络数据 */
    [self loadInternetData];
}

#pragma mark - 加载网络数据
- (void)loadInternetData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pid"] = self.product_id;
    [manager POST:Product_Detail_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        ZXResponseObject
       self.detailModel = [ZXProuctDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self.productDetailTableview reloadData];
        /*
         {
         data =     {
         commList =         (
         {
         commision = 10;
         earnings = 10;
         id = 1;
         maxAmount = 100;
         minAmount = 0;
         productId = 1;
         status = 1;
         },
         {
         commision = 9;
         earnings = 10;
         id = 2;
         maxAmount = 200;
         minAmount = 100;
         productId = 1;
         status = 1;
         },
         {
         commision = 9;
         earnings = 10;
         id = 3;
         maxAmount = 0;
         minAmount = 200;
         productId = 1;
         status = 1;
         }
         );
         commision = 9;
         commisionType = 31;
         commisionTypeName = "";
         createTime = "<null>";
         earmarking = "中江信托-金鹤131号（第五期）";
         earnings = 10;
         enclosure = "中江信托-金鹤131号（第五期）";
         endRow = 0;
         financing = "阿斯达是的";
         initialAmount = 22;
         initialAmountName = "";
         isCollection = 0;
         isControll = 1;
         isRecommend = 1;
         issuer = 18;
         issuerName = "";
         labelId =         (
         );
         labelList =         (
         {
         id = 20;
         labelId = 30;
         labelName = "一年期";
         productId = 1;
         status = 1;
         },
         {
         id = 19;
         labelId = 9;
         labelName = "半年付息";
         productId = 1;
         status = 1;
         },
         {
         id = 18;
         labelId = 8;
         labelName = "2年期";
         productId = 1;
         status = 1;
         },
         {
         id = 17;
         labelId = 7;
         labelName = "AA主体";
         productId = 1;
         status = 1;
         },
         {
         id = 16;
         labelId = 6;
         labelName = "工商企业类";
         productId = 1;
         status = 1;
         }
         );
         measures = "中江信托-金鹤131号（第五期）";
         pageIndex = 0;
         pageSize = 0;
         payInterest = 26;
         payInterestName = "";
         payment = "中江信托-金鹤131号（第五期）";
         proId = 1;
         productAllTitle = "中江信托-金鹤131号（第五期）";
         productDeadline = 1;
         productDeadlineName = "<12个月";
         productDesc = "中江信托-金鹤131号（第五期）";
         productField = 14;
         productFieldName = "";
         productTitle = "中江信托-金鹤131号（第五期）";
         productType = 1;
         productTypeName = "信托";
         project = "中江信托-金鹤131号（第五期）";
         raiseAccount = "中江信托-金鹤131号（第五期）";
         raiseScale = "15亿";
         salesArea = "青岛";
         salesDesc = "第五期开放搭款中";
         salesStatus = 11;
         salesStatusName = "开放募集";
         sellers = "金经理";
         sort = 0;
         startRow = 0;
         status = 0;
         totalNum = 0;
         updateTime =         {
         date = 7;
         day = 3;
         hours = 16;
         minutes = 54;
         month = 8;
         seconds = 38;
         time = 1473238478000;
         timezoneOffset = "-480";
         year = 116;
         };
         };
         msg = "查询成功";
         status = 1;
         token = "";
         }
         */
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
        (self.collectedBtn.selected)?( [MBProgressHUD showSuccess:@"收藏成功!"]):([MBProgressHUD showSuccess:@"收藏取消!"]);
    }else{
        LoginController *login = [[LoginController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        [kWindowRootController presentViewController:nav animated:YES completion:nil];
    }
    
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
