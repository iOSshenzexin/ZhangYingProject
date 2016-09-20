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
@interface DealController ()<UITableViewDelegate,UITableViewDataSource,PopoverViewDelegate>

@property (nonatomic,copy) NSArray *titleArray;
@property (nonatomic,copy) NSArray *imgArray;
@property (nonatomic,strong) PopoverView *pop;
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

static NSString *defaultCell = @"defaultCell";

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
    [self.dealTableView registerNib:[UINib nibWithNibName:@"DealTopCustomCell" bundle:nil] forCellReuseIdentifier:cellId];
    self.dealTableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    self.dealTableView.sectionFooterHeight = 20;
    self.dealTableView.sectionHeaderHeight = 0;
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
        DealTopCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[DealTopCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        self.seg = cell.segmentControl;
        [cell.showCardBtn addTarget:self action:@selector(didClickCheckCardInfo:) forControlEvents:UIControlEventTouchUpInside];
        self.seg.selectedSegmentIndex = cell.segmentControl.selectedSegmentIndex;
        [cell.segmentControl addTarget:self action:@selector(didClickSegmentControler:) forControlEvents:UIControlEventValueChanged];
        [cell.collectionBtn addTarget:self action:@selector(didClickEnterCollection:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shareBtn addTarget:self action:@selector(didClickEnterShare:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCell];
     if (!cell) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCell];
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
    vc.title = @"我的收藏";
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
    self.seg.selectedSegmentIndex = 0;
    CGFloat pointOneX = self.seg.center.x - 130;
    CGFloat pointOneY = self.seg.center.y - 10;
    CGPoint point = CGPointMake(pointOneX, pointOneY);
    PopoverView *pop = [PopoverView sharedPopview];
    pop.delegate = self;
    self.pop = pop;
    [pop showAtPoint:point inView:self.seg withText:@"· 交易成功 10 单 · 进行中 8 单 · 交易失败 0 单"];
}

- (void)didClickSegmentControler:(UISegmentedControl *)segmentControl{
    CGFloat pointOneY = segmentControl.center.y-10;
    switch (segmentControl.selectedSegmentIndex) {
        case 0:{
            CGFloat pointOneX = segmentControl.center.x - 130;
            CGPoint point = CGPointMake(pointOneX, pointOneY);
            [self.pop showAtPoint:point inView:segmentControl withText:@"· 交易成功 10 单 · 进行中 8 单 · 交易失败 0 单"];
        }
            break;
                case 1:{
                    CGFloat pointOneX = segmentControl.center.x;
                    CGPoint point = CGPointMake(pointOneX, pointOneY);
                    [self.pop showAtPoint:point inView:segmentControl withText:@"· 我的佣金 1000.00 元 · 已提现金额 800.00 元 · 可提现金额 10000 元"];
                }
            break;
        case 2:{
            CGFloat pointOneX = segmentControl.center.x + 130;
            CGPoint point = CGPointMake(pointOneX, pointOneY);
            [self.pop showAtPoint:point inView:segmentControl withText:@"· 我的预约 10 单 · 进行中 8 单 · 收藏预约 20 单"];
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
        return 230;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                self.hidesBottomBarWhenPushed = YES;
                MyReservationController *vc = [[MyReservationController alloc] init];
                vc.title = @"我的预约";
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 1:{
                self.hidesBottomBarWhenPushed = YES;
                MyOrderController *vc = [[MyOrderController alloc] init];
                vc.title = @"我的订单";
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 2:{
                self.hidesBottomBarWhenPushed = YES;
                ProductRequirementController *vc = [[ProductRequirementController alloc] init];
                vc.title = @"产品需求";
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 3:{
                self.hidesBottomBarWhenPushed = YES;
                ProductAnnouncementController *vc = [[ProductAnnouncementController alloc] init];
                vc.title = @"产品公告";
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
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
