//
//  AppDelegate.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/18.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "AppDelegate.h"
#import "TabbarController.h"
#import "LoginController.h"
#import "FloatingView.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置友盟Appkey
    [self useUmengSDK];
    //[UMSocialData setAppKey:UMengAppKey];
    
    
    //启用IQKeyboardManager
    [self useIQKeyboardManager];
    //实时监测网络状态,reachabilityForInternetConnection改变了调用两次的情况
    self.hostReach = [Reachability reachabilityForInternetConnection] ;
    [self.hostReach startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    TabbarController *tabBarController = [[TabbarController alloc] init];
    tabBarController.delegate = self;
    window.rootViewController = tabBarController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem = tabBar.items[2];
    tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
//    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIColor *color =  RGB(230, 230, 230, 1);
//    CGContextSetFillColorWithColor(context,[color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    tabBar.backgroundImage = image;
    
    //更改导航栏的颜色跟字体颜色
    UIColor * navigationBarColor = RGB(216,38,35,1);
    [[UINavigationBar appearance] setBarTintColor: navigationBarColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:16.f]}];
    //更改状态栏的颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = window;
    [window makeKeyAndVisible];
    
    ZXLoginModel *model = AppLoginModel;
    if (model) {
        self.isLogin = YES;
    }

    
    //添加悬浮窗
    FloatingView * floatingView = [[FloatingView alloc]initWithFrame:CGRectMake(ScreenW - 54, ScreenH - 110, 52.5, 52.5)];
    [self.window.rootViewController.view addSubview:floatingView];
    
    [self fixTextViewInitSlowly];
    
    return YES;
}


- (void)useUmengSDK{
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengAppKey];
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeChatAppId appSecret:WeChatAppKey redirectURL:@"http://mobile.umeng.com/social"];
}

- (void)useIQKeyboardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    manager.toolbarManageBehaviour =IQAutoToolbarByTag;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (void)fixTextViewInitSlowly{
    UITextView *textView = [[UITextView alloc] init];
    [self.window addSubview:textView];
    [textView removeFromSuperview];
}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    self.selectedIndex = [tabBarController.viewControllers indexOfObject:viewController];
//    NSLog(@"--tabbaritem.index--%lu",[tabBarController.viewControllers indexOfObject:viewController]);
    if ([viewController.tabBarItem.title isEqualToString:@"交易"] | [viewController.tabBarItem.title isEqualToString:@"我的"] ) {
        //如果用户ID存在的话，说明已登陆
        if (self.isLogin == YES) {
            return YES;
        }else{ //跳到登录页面
        ([viewController.tabBarItem.title isEqualToString:@"交易"])?(self.selectedIndex = 3):(self.selectedIndex = 4);
           LoginController *login = [[LoginController alloc] init];
          //确定当前选择的第几个controller
           login.selectedIndex = [tabBarController.viewControllers indexOfObject:viewController];
           UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
           //nav.navigationBarHidden = YES;
           [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
            return NO;
        }
    }
    else return YES;
}

- (void)reachabilityChanged:(NSNotification *)note{
    NSLog(@"%s",__func__);
    Reachability *currReach = [note object];
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    if(status == NotReachable){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry,您当前网络连接异常!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        self.isReachable = NO;
        return;
    }
    if (status== ReachableViaWiFi | status== ReachableViaWWAN ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Congratulation,您当前网络连接正常!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        self.isReachable = YES;
        return;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "vshoutao.com.ZhangYingProject" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ZhangYingProject" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ZhangYingProject.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.hostReach stopNotifier];
}
@end
