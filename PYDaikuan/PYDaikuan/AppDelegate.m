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

@interface AppDelegate ()

@end

bool onlineSetting = false;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NSThread sleepForTimeInterval:4.0];//设置启动页面时间
    
    onlineSetting = true;
    
    DKIndexViewController *indexViewController = [[DKIndexViewController alloc] init];
    DKNavigationController *indextNC = [[DKNavigationController alloc] initWithRootViewController:indexViewController];
    indextNC.title = @"一键贷款";
    
    DKNewsViewController *newsViewController = [[DKNewsViewController alloc] init];
    DKNavigationController *newsNC = [[DKNavigationController alloc] initWithRootViewController:newsViewController];
    newsNC.title = @"贷款咨询";
    
    DKWebViewController *toolViewController = [[DKWebViewController alloc] initWithUrl:@"https://www.baidu.com/"];
    DKNavigationController *toolNC = [[DKNavigationController alloc] initWithRootViewController:toolViewController];
    toolNC.title = @"贷款工具";
    
    UITabBarController *mainTabBarController = [[UITabBarController alloc] init];
    
    if (onlineSetting) {
        DKWebViewController *CreditCardVC = [[DKWebViewController alloc] initWithUrl:@"http://8.yun.haodai.com/Mobile/creditcard?ref=hd_11014405"];
        UINavigationController *CreditCardNC = [[UINavigationController alloc] initWithRootViewController:CreditCardVC];
        CreditCardVC.title = @"信用卡";
        
        UIViewController *fifthVC = [[UIViewController alloc] init];
        fifthVC.view.backgroundColor = [UIColor yellowColor];
        UINavigationController *fifthNC = [[UINavigationController alloc] initWithRootViewController:fifthVC];
        fifthNC.title = @"贷款推荐";
        
        [mainTabBarController setViewControllers:@[indextNC,CreditCardNC,fifthNC,newsNC,toolNC]];
    }
    else {
        [mainTabBarController setViewControllers:@[indextNC,newsNC,toolNC]];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = mainTabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
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
