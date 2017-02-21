//
//  AppDelegate.m
//  GWNetDemo
//
//  Created by apple on 17/2/21.
//  Copyright © 2017年 YuanHongQiang. All rights reserved.
//

#import "AppDelegate.h"
#import "GWNet.h"

#import "MainVC.h"

@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //在使用gwnet时要初始化公共参数,注意,这些参数需要向我司申请才能提供,以下仅供测试使用
    GWNetSingleton.theAppId=@"c303031f0bb7fd896d6174d21dc12eb3";
    GWNetSingleton.theAppToken=@"938e12c1850d8cd8d5b3778f8d0057ed93eabe237beb7784fc2e990d253ef457";
    GWNetSingleton.theAppName=@"GWNetDemo";
    GWNetSingleton.theAppVersion=@"04.17.1.0";
    
    
    _window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.rootViewController=[[MainVC alloc] init];
    _window.backgroundColor=[UIColor whiteColor];
    [_window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}
- (void)applicationWillTerminate:(UIApplication *)application {
    
}
@end
