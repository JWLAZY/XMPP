//
//  AppDelegate.m
//  0834XMPP
//
//  Created by 郑建文 on 15/11/24.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 这个方法会让self.window的rootviewcontroller指向main 的 入口控制器
    [self.window makeKeyAndVisible];
    
    //获取到登陆和注册的sb
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil];
    
    //取到登陆界面(入口控制器)
    UIViewController *vc = [sb instantiateInitialViewController];
    
    //在main 的sb 上面模态出来一个登陆界面
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
    
    
    
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
