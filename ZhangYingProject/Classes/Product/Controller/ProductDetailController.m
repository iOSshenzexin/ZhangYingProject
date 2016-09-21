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
@interface ProductDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation ProductDetailController
- (IBAction)didClickShowProductShare:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    ProductShareController *vc = [[ProductShareController alloc] init];
    vc.title = @"产品分享";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didClickProductReservation:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    ProductReservationController *vc = [[ProductReservationController alloc] init];
    vc.title = @"预约";
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"募集账号",@"资金用途",@"还款来源",@"融资方介绍",@"风控措施", @"项目亮点",@"产品附件",nil];
    }
    return _titleArray;
}

static NSString *styleOne = @"styleOne";
static NSString *styleTwo = @"styleTwo";
static NSString *styleThree = @"styleThree";
static NSString *styleFour = @"styleFour";
static NSString *styleDefault = @"styleDefault";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCustomCell];
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
        ZXLog(@"responseObject %@",responseObject);
        /*
         {
         data =     {
         commision = 9;
         commisionType = 1;
         commisionTypeName = "";
         createTime = "<null>";
         earmarking = "中江信托-金鹤131号（第五期）";
         earnings = 10;
         enclosure = "中江信托-金鹤131号（第五期）";
         endRow = 0;
         financing = "阿斯达是的";
         initialAmount = 22;
         initialAmountName = "";
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
         salesDesc = "第五期开放搭款中";
         salesStatus = 11;
         salesStatusName = "开放募集";
         sort = 0;
         startRow = 0;
         status = 1;
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


- (void)registerCustomCell{
    [self.productDetailTableview registerNib:[UINib nibWithNibName:@"ProductDetailStyleOneCustomCell" bundle:nil] forCellReuseIdentifier:styleOne];
    [self.productDetailTableview registerNib:[UINib nibWithNibName:@"ProductDetailStyleTwoCustomCell" bundle:nil] forCellReuseIdentifier:styleTwo];
    [self.productDetailTableview registerNib:[UINib nibWithNibName:@"ProductDetailStyleThreeCustomCell" bundle:nil] forCellReuseIdentifier:styleThree];
    [self.productDetailTableview registerNib:[UINib nibWithNibName:@"ProductDetailStyleFourCustomCell" bundle:nil] forCellReuseIdentifier:styleFour];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ProductDetailStyleOneCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:styleOne];
        if (!cell) {
            cell = [[ProductDetailStyleOneCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:styleOne];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.borderWidth = 3;
        UIColor *color = RGB(242, 242, 242, 1);
        cell.layer.borderColor = [color CGColor];
        return cell;
    }
    if (indexPath.row == 1) {
        ProductDetailStyleTwoCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:styleTwo];
        if (!cell) {
            cell = [[ProductDetailStyleTwoCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:styleTwo];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.borderWidth = 3;
        UIColor *color = RGB(242, 242, 242, 1);
        cell.layer.borderColor = [color CGColor];
        return cell;
    }
    if (indexPath.row == 2) {
        ProductDetailStyleThreeCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:styleThree];
        if (!cell) {
            cell = [[ProductDetailStyleThreeCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:styleThree];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.borderWidth = 3;
        UIColor *color = RGB(242, 242, 242, 1);
        cell.layer.borderColor = [color CGColor];
        return cell;
    }
    if (indexPath.row == 3) {
        ProductDetailStyleFourCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:styleFour];
        if (!cell) {
            cell = [[ProductDetailStyleFourCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:styleFour];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.borderWidth = 3;
        UIColor *color = RGB(242, 242, 242, 1);
        cell.layer.borderColor = [color CGColor];
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
        return 265;
    }
    if (indexPath.row == 3) {
        return 105;
    }
    return 44;
}

- (IBAction)didClickCollecting:(id)sender {
    self.collectedBtn.selected = !self.collectedBtn.selected;
    if (self.collectedBtn.selected) {
        [MBProgressHUD showSuccess:@"收藏成功!"];
        [self.collectedBtn setImage:[UIImage imageNamed:@"pro2-details09"] forState:UIControlStateSelected];
    }else{
        [MBProgressHUD showSuccess:@"收藏取消!"];
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
                window.contentTxt.text = @"1.新加坡总理李显龙21日发表长篇演说时突显不适，收看电视转播的观众表示担忧\n 2.不过医生表示情况并不严重，他也在休息后继续完成演说，并提及计划下次大选后交棒给接班人。";
                window.titleLabel.text = @"募集账号";
                break;
            case 5:
                window.contentTxt.text = @"1.8月21日，重庆市气象台发布“高温红色预警”信号。市民在高温天气的火车钢轨上进行实验，把新鲜的肉和鸡蛋放在滚烫的地面上，温度表显示的实时地面温度已达到温度表的最高值50℃\n2.一个小时的时间，肉和鸡蛋几乎都被高温的地面烫熟。";
                window.titleLabel.text = @"资金用途";
                break;
            case 6:
                window.contentTxt.text = @"1.陕西省榆林市西南方向，距市中心约20公里的毛乌素沙漠边缘地带，一处现代化居民小区孤零零地矗立在荒漠中。\n2.过去四年内，当地2000多户居民将多年的积蓄投入这座名为“凤凰新城”的政府保障房小区，希望在这里实现自己的安居梦。\n3.如今，23栋已竣工近2年的住宅楼，却由于周边配套设施严重滞后以及小区内基础设施缺失，而仅仅收获了不足10%的入住率，俨然成为了沙漠中的“孤岛”。";
                window.titleLabel.text = @"还款来源";
                break;
            case 7:
                window.contentTxt.text = @"1.陕西省榆林市西南方向，距市中心约20公里的毛乌素沙漠边缘地带，一处现代化居民小区孤零零地矗立在荒漠中。\n2.过去四年内，当地2000多户居民将多年的积蓄投入这座名为“凤凰新城”的政府保障房小区，希望在这里实现自己的安居梦。\n3.如今，23栋已竣工近2年的住宅楼，却由于周边配套设施严重滞后以及小区内基础设施缺失，而仅仅收获了不足10%的入住率，俨然成为了沙漠中的“孤岛”。\n4.陕西省榆林市西南方向，距市中心约20公里的毛乌素沙漠边缘地带，一处现代化居民小区孤零零地矗立在荒漠中。\n5.过去四年内，当地2000多户居民将多年的积蓄投入这座名为“凤凰新城”的政府保障房小区，希望在这里实现自己的安居梦。\n6.如今，23栋已竣工近2年的住宅楼，却由于周边配套设施严重滞后以及小区内基础设施缺失，而仅仅收获了不足10%的入住率，俨然成为了沙漠中的“孤岛”。\n7.陕西省榆林市西南方向，距市中心约20公里的毛乌素沙漠边缘地带，一处现代化居民小区孤零零地矗立在荒漠中。\n8.过去四年内，当地2000多户居民将多年的积蓄投入这座名为“凤凰新城”的政府保障房小区，希望在这里实现自己的安居梦。\n9.如今，23栋已竣工近2年的住宅楼，却由于周边配套设施严重滞后以及小区内基础设施缺失，而仅仅收获了不足10%的入住率，俨然成为了沙漠中的“孤岛”。";
                window.titleLabel.text = @"融资方介绍";
                break;
            case 8:
                window.contentTxt.text = @"";
                window.titleLabel.text = @"风控措施";
                break;
            case 9:
                window.contentTxt.text = @"";
                window.titleLabel.text = @"项目亮点";
                break;
            case 10:
                window.contentTxt.text = @"";
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
