//
//  MineController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "MineController.h"
#import "ZXCircleHeadImage.h"
#import "PersonInfoController.h"
#import "MemberAuthenticationController.h"
#import "MyWalletController.h"
#import "MyCardController.h"

#import "DealSettingController.h"
#import "SecuritySetController.h"
#import "AboutUsController.h"

#import "LoginController.h"
@interface MineController ()<UITableViewDelegate,UITableViewDataSource,PersonInfoControllerDelegate>

@property (nonatomic,copy) NSArray *dataSource;
@property (nonatomic,copy) NSArray *imageArray;

- (IBAction)didClickSetPersonInfo:(id)sender;

@end

@implementation MineController

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if(!appDlg.isReachable){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry,您当前网络连接异常!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
//}

-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray arrayWithObjects:@"交易设置",@"安全设置",@"关于我们",@"呼叫客服",@"邀请好友", nil];
    }
    return _dataSource;
}

-(NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSArray arrayWithObjects:@"my-icon01",@"my-icon02",@"my-icon03",@"my-icon04",@"my-icon04",nil];
    }
    return _imageArray;
}

  //设置个人信息
- (IBAction)didClickSetPersonInfo:(id)sender {
    PersonInfoController *vc = [PersonInfoController sharedPersonController];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"个人资料";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    PersonInfoController *vc = [PersonInfoController sharedPersonController];
    vc.delegate = self;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
    self.tableView.sectionFooterHeight = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ZXLoginModel *model = AppLoginModel;
    if(model){
        self.nickName.text = [NSString stringWithFormat:@"%.0f",model.phone];
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:[baseUrl stringByAppendingString:model.headPortrait]] placeholderImage:[ZXCircleHeadImage clipOriginImage:[UIImage imageNamed:@"my-phone"] scaleToSize:self.headImage.frame.size borderWidth:2 borderColor:[UIColor redColor]]];
    }else{
        self.headImage.image = [UIImage imageNamed:@"my-phone"] ;
    }
}


-(void)setupUserHeadImage:(PersonInfoController *)vc{
    self.headImage.image = vc.headImageBtn.currentImage;
    self.nickName.text = vc.userName;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];

    cell.detailTextLabel.text = @"设置结佣账户和收货地址";
    cell.detailTextLabel.font = [UIFont fontWithName:@"Thin" size:12.f];
    if (indexPath.row == 3) {
        cell.detailTextLabel.text = @"400-666-8888";
        cell.detailTextLabel.textColor = [UIColor redColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeServiceCall:)];
        cell.detailTextLabel.userInteractionEnabled = YES;
        [cell.detailTextLabel addGestureRecognizer:tap];
    }
    return cell;
}

- (void)makeServiceCall:(UITapGestureRecognizer *)tap{
    UIWebView *callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel://400-666-8888"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            DealSettingController *vc = [[DealSettingController alloc] init];
            vc.title = @"交易设置";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:{
            SecuritySetController *vc = [[SecuritySetController alloc] init];
            vc.title = @"安全设置";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            AboutUsController *vc = [[UIStoryboard storyboardWithName:@"AboutUsController" bundle:nil]instantiateViewControllerWithIdentifier:@"aboutUs"];
            vc.title = @"关于我们";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}


- (IBAction)memberAuthenticationBtn:(id)sender {
    MemberAuthenticationController *vc = [[MemberAuthenticationController alloc] init];
    vc.title = @"身份认证";
    vc.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didClickEnterMyWallet:(id)sender {
    MyWalletController *vc = [[MyWalletController alloc] init];
    vc.title = @"钱包";
    vc.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didClickEnterMyCard:(id)sender {
    MyCardController *vc = [[MyCardController alloc] init];
    vc.title = @"我的卡券";
    vc.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didClickExitLogin:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您确定要退出吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:cancleAction];
    
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIApplication *application = [UIApplication sharedApplication];
        TabbarController *tab = (TabbarController *) application.keyWindow.rootViewController;
    //    tab.selectedIndex = 2;
        LoginController *vc = [[LoginController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        AppDelegate *app = (AppDelegate *) [UIApplication sharedApplication].delegate;
        app.isLogin = NO;
        vc.quit = 1;
        [tab presentViewController:nav animated:YES completion:^{
            [StandardUser removeObjectForKey:loginModel];
        }];
    }];
    [alertController addAction:determineAction];
    [self presentViewController:alertController animated:YES completion:nil];
}




@end
