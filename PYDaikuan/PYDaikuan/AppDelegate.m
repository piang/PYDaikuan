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
#import "DKCaculateViewController.h"
#import "DKPersonalTaxViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UMMobClick/MobClick.h"

@interface AppDelegate ()

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
            [query getObjectInBackgroundWithId:@"57cce2bca22b9d006ba3c5a0" block:^(AVObject *object, NSError *error) {
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
    UMConfigInstance.channelId = @"PYDaikuanFirst";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    [NSThread sleepForTimeInterval:4.0];//设置启动页面时间

    
    return YES;
}

- (void)setupViewController {

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *mainTabBarController = [[UITabBarController alloc] init];
    
    DKNewsViewController *newsViewController = [[DKNewsViewController alloc] init];
    DKNavigationController *newsNC = [[DKNavigationController alloc] initWithRootViewController:newsViewController];
    newsNC.title = @"贷款资讯";
    newsNC.tabBarItem.image = [UIImage imageNamed:@"remendaikuanhui"];
    
    DKCaculateViewController *toolViewController = [[DKCaculateViewController alloc] init];
    DKNavigationController *toolNC = [[DKNavigationController alloc] initWithRootViewController:toolViewController];
    toolNC.title = @"贷款计算器";
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
        
        DKPersonalTaxViewController *personalTaxViewController = [[DKPersonalTaxViewController alloc] init];
        DKNavigationController *personalNC = [[DKNavigationController alloc] initWithRootViewController:personalTaxViewController];
        personalNC.title = @"个人所得税计算器";
        personalNC.tabBarItem.image = [UIImage imageNamed:@"loan"];
        [mainTabBarController setViewControllers:@[newsNC,toolNC,personalNC]];
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

@end
