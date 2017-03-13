//
//  AppDelegate.m
//  PYDaikuan
//
//  Created by 洋 裴 on 16/8/13.
//  Copyright © 2016年 piang. All rights reserved.
//

#import "AppDelegate.h"
#import "DKIndexViewController.h"
#import "DKNavigationController.h"
#import "DKNewsViewController.h"
#import "DKWebViewController.h"
#import "DKAllCaculateViewController.h"
#import "DKBankTelViewController.h"
#import "DKAccountViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UMMobClick/MobClick.h"
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import <UMSocialCore/UMSocialCore.h>
#endif

#define USHARE_DEMO_APPKEY @"5861e5daf5ade41326001eab"

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

bool onlineSetting = false;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    onlineSetting = [[[NSUserDefaults standardUserDefaults] objectForKey:@"onlineSetting"] boolValue];
    
    if (onlineSetting) {
        [self setupViewController];
    }
    
    else {
        [AVOSCloud setApplicationId:@"XpuV4q5fN2hj9hGr4CwzYvHO-gzGzoHsz" clientKey:@"vOcE9YRm4PLFdxv3GYrnkTVb"];
        [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        
        AVQuery *query = [AVQuery queryWithClassName:@"channel_switch"];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [query getObjectInBackgroundWithId:@"58c6a7d22f301e006bcb2df4" block:^(AVObject *object, NSError *error) {
                NSLog(@"object%@",object);
                if ([object[@"is_open"] boolValue]) {
                    onlineSetting = true;
                    [[NSUserDefaults standardUserDefaults] setObject:@(onlineSetting) forKey:@"onlineSetting"];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setupViewController];
                });
                
            }];
        });
    }
    
    UMConfigInstance.appKey = @"58731c8fb27b0a2ace001492";
    UMConfigInstance.channelId = @"PYMoneyRoad";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self configUSharePlatforms];
    
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"4d694f29a1501b6c759c8e28"
                          channel:@"appstore"
                 apsForProduction:1
            advertisingIdentifier:nil];
    
    [NSThread sleepForTimeInterval:4.0];//设置启动页面时间
    
    return YES;
}

- (void)setupViewController {

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *mainTabBarController = [[UITabBarController alloc] init];
    
    DKNewsViewController *newsViewController = [[DKNewsViewController alloc] initWithType:0];
    DKNavigationController *newsNC = [[DKNavigationController alloc] initWithRootViewController:newsViewController];
    newsNC.title = @"贷款资讯";
    newsNC.tabBarItem.image = [UIImage imageNamed:@"remendaikuanhui"];
    
    DKAllCaculateViewController *toolViewController = [[DKAllCaculateViewController alloc] init];
    DKNavigationController *toolNC = [[DKNavigationController alloc] initWithRootViewController:toolViewController];
    toolNC.title = @"计算器";
    toolNC.tabBarItem.image = [UIImage imageNamed:@"jisuanqihui"];
    
    
    if (onlineSetting) {
        
        DKIndexViewController *indexViewController = [[DKIndexViewController alloc] init];
        DKNavigationController *indextNC = [[DKNavigationController alloc] initWithRootViewController:indexViewController];
        indextNC.title = @"一键贷款";
        indextNC.tabBarItem.image = [UIImage imageNamed:@"loan"];
        
        DKWebViewController *creditCardVC = [[DKWebViewController alloc] initWithUrl:@"http://8.yun.haodai.com/Mobile/creditcard?ref=hd_11014405"];
        UINavigationController *creditCardNC = [[UINavigationController alloc] initWithRootViewController:creditCardVC];
        creditCardNC.title = @"信用卡";
        creditCardNC.tabBarItem.image = [UIImage imageNamed:@"bank"];
        
        DKWebViewController *recommandVC = [[DKWebViewController alloc] initWithUrl:@"https://m.rong360.com/express?from=sem21&utm_source=dl&utm_medium=cpa&utm_campaign=sem21"];
        UINavigationController *recommandNC = [[UINavigationController alloc] initWithRootViewController:recommandVC];
        recommandNC.title = @"贷款推荐";
        recommandNC.tabBarItem.image = [UIImage imageNamed:@"iconmarka"];
        
        [mainTabBarController setViewControllers:@[indextNC,creditCardNC,recommandNC,newsNC,toolNC]];
    }
    else {
        
        DKBankTelViewController *bankTelViewController = [[DKBankTelViewController alloc] init];
        DKNavigationController *bankNC = [[DKNavigationController alloc] initWithRootViewController:bankTelViewController];
        bankNC.title = @"银行客服";
        bankNC.tabBarItem.image = [UIImage imageNamed:@"bank"];
        
        DKAccountViewController *accountViewController = [[DKAccountViewController alloc] init];
        DKNavigationController *accountNC = [[DKNavigationController alloc] initWithRootViewController:accountViewController];
        accountNC.title = @"个人信息";
        accountNC.tabBarItem.image = [UIImage imageNamed:@"loan"];
        
        [mainTabBarController setViewControllers:@[newsNC,toolNC,bankNC,accountNC]];
    }
    
    self.window.rootViewController = mainTabBarController;
    
    [self.window makeKeyAndVisible];

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
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
