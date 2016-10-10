//
//  DealController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "DealController.h"

#import "DealTopCustomCell.h"

#import "MyReservationController.h"

#import "PopoverView.h"

#import "MyWalletController.h"
#import "MyOrderController.h"
#import "ProductAnnouncementController.h"
#import "ProductRequirementController.h"
#import "MyCollectionController.h"
#import "MyShareController.h"
@interface DealController ()<UITableViewDelegate,UITableViewDataSource,PopoverViewDelegate>{
    NSString *_billString;
    NSString *_commissionString;
    NSString *_reservationString;
}

@property (nonatomic,copy) NSArray *titleArray;

@property (nonatomic,copy) NSArray *imgArray;

@property (nonatomic,strong) PopoverView *pop;

@property (nonatomic,copy) NSDictionary *dataDictionary;
@end

@implementation DealController

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if(!appDlg.isReachable){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry,您当前网络连接异常!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
//    
//}

static NSString *cellId = @"cell";

+ (DealController *)sharedDealController{
    static DealController *vc = nil;
    if (!vc) {
        vc = [[DealController alloc] init];
    }
    return vc;
}

-(NSArray *)imgArray{
    if (!_imgArray) {
        _imgArray = [NSArray arrayWithObjects:@"trade-icon04",@"trade-icon05",@"trade-icon06",@"trade-icon07", nil];
    }
    return _imgArray;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"我的预约",@"我的订单",@"产品需求",@"产品公告", nil];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dealTableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    self.dealTableView.sectionFooterHeight = 10;
    self.dealTableView.sectionHeaderHeight = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestDealHomeStatics];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==1) return 4;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DealTopCustomCell *cell = [DealTopCustomCell cellWithTableview:tableView];
        self.seg = cell.segmentControl;
        [cell.showCardBtn addTarget:self action:@selector(didClickCheckCardInfo:) forControlEvents:UIControlEventTouchUpInside];
        self.seg.selectedSegmentIndex = cell.segmentControl.selectedSegmentIndex;
        [cell.segmentControl addTarget:self action:@selector(didClickSegmentControler:) forControlEvents:UIControlEventValueChanged];
        [cell.collectionBtn setTitle:[NSString stringWithFormat:@"关注 %@",self.dataDictionary[@"collCount"]] forState:UIControlStateNormal];
        [cell.collectionBtn addTarget:self action:@selector(didClickEnterCollection:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shareBtn setTitle:[NSString stringWithFormat:@"分享 %@",self.dataDictionary[@"shareCount"]] forState:UIControlStateNormal];
        [cell.shareBtn addTarget:self action:@selector(didClickEnterShare:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
     if (!cell) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.titleArray[indexPath.row];
        cell.imageView.image =[UIImage imageNamed:self.imgArray[indexPath.row]];
        return cell;
    }
    return nil;
}


- (void)didClickEnterShare:(UIButton *)btn{
    MyShareController *vc = [[MyShareController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"分享记录";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickEnterCollection:(UIButton *)btn{
    MyCollectionController *vc = [[MyCollectionController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"我的关注";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didClickCheckCardInfo:(UIButton *)btn{
    MyWalletController *vc = [[MyWalletController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"我的钱包";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   // [self requestDealHomeStatics];
    [self.view setNeedsDisplay];
//    self.seg.selectedSegmentIndex = 0;
//    CGFloat pointOneX = self.seg.center.x - 130;
//    CGFloat pointOneY = self.seg.center.y - 10;
//    CGPoint point = CGPointMake(pointOneX, pointOneY);
//    PopoverView *pop = [PopoverView sharedPopview];
//    pop.delegate = self;
//    self.pop = pop;
//    [pop showAtPoint:point inView:self.seg withText:@"· 交易成功 0 单 · 进行中 0 单 · 交易失败 0 单"];
}

- (void)requestDealHomeStatics
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZXLoginModel *model = AppLoginModel;
    params[@"mid"] = model.mid;
    [manager POST:Deal_HomeStatistics_Url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        self.dataDictionary = dic;
        _billString = [NSString stringWithFormat:@"· 交易成功 %@ 单 · 进行中 %@ 单 · 交易失败 %@ 单",dic[@"orderCount2"],dic[@"orderCount1"],dic[@"orderCount3"]];
        _commissionString = [NSString stringWithFormat:@"· 我的佣金 %.2f 元 · 已提现金额 %.2f 元 · 可提现金额 %.2f 元",model.allCommision,(model.allCommision-model.commision),model.commision];
        _reservationString = [NSString stringWithFormat:@"· 预约成功 %@ 单 · 进行中 %@ 单 · 预约失败 %@ 单",dic[@"makeCount2"],dic[@"makeCount1"],dic[@"makeCount3"]];
        self.seg.selectedSegmentIndex = 0;
        CGFloat pointOneX = self.seg.center.x - 130;
        CGFloat pointOneY = self.seg.center.y - 10;
        CGPoint point = CGPointMake(pointOneX, pointOneY);
        PopoverView *pop = [PopoverView sharedPopview];
        pop.delegate = self;
        self.pop = pop;
        [pop showAtPoint:point inView:self.seg withText:_billString];
        [self.dealTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXError
    }];
}

- (void)didClickSegmentControler:(UISegmentedControl *)segmentControl{
    CGFloat pointOneY = segmentControl.center.y-10;
    switch (segmentControl.selectedSegmentIndex) {
        case 0:{
            CGFloat pointOneX = segmentControl.center.x - 130;
            CGPoint point = CGPointMake(pointOneX, pointOneY);
            [self.pop showAtPoint:point inView:segmentControl withText:_billString];
        }
            break;
                case 1:{
                    CGFloat pointOneX = segmentControl.center.x;
                    CGPoint point = CGPointMake(pointOneX, pointOneY);
                    [self.pop showAtPoint:point inView:segmentControl withText:_commissionString];
                }
            break;
        case 2:{
            CGFloat pointOneX = segmentControl.center.x + 130;
            CGPoint point = CGPointMake(pointOneX, pointOneY);
            [self.pop showAtPoint:point inView:segmentControl withText:_reservationString];
        }
            break;
        default:
            break;
    }
}

#pragma mark - PopoverViewDelegate Methods

-(void)popoverViewdidSetupPopview:(PopoverView *)popoverView{
    CGFloat x1 = self.seg.frame.origin.x;
    CGFloat x2 = self.seg.frame.origin.x + self.seg.frame.size.width * (1/3.0);
    CGFloat x3 = self.seg.frame.origin.x + self.seg.frame.size.width * (2/3.0);
    CGFloat x4 = self.seg.frame.origin.x + self.seg.frame.size.width;
    if (popoverView.point.x >= x1 && popoverView.point.x <= x2) {
        self.seg.selectedSegmentIndex = 0;
    }
    if (popoverView.point.x >= x2 && popoverView.point.x <= x3) {
        self.seg.selectedSegmentIndex = 1;
    }
    if (popoverView.point.x >= x3 && popoverView.point.x <= x4) {
        self.seg.selectedSegmentIndex = 2;
    }
    [self performSelector:@selector(didClickSegmentControler:) withObject:self.seg];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 205;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                MyReservationController *vc = [[MyReservationController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = @"我的预约";
            [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:{
                MyOrderController *vc = [[MyOrderController alloc] init];
                vc.title = @"我的订单";
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:{
                ProductRequirementController *vc = [[ProductRequirementController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = @"产品需求";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:{
                ProductAnnouncementController *vc = [[ProductAnnouncementController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = @"产品公告";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.pop removeFromSuperview];
    [self.pop.contentView removeFromSuperview];
}


@end
