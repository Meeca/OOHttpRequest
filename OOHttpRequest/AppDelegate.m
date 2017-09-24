//
//  AppDelegate.m
//  OOHttpRequest
//
//  Created by feng on 2017/9/19.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "AppDelegate.h"
#import "OONetworking.h"
#import <LxDBAnything/LxDBAnything.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [OOHttpManager sharedInstance].baseUrl = @"http://www.pidans.xyz";
    
//    http://www.pidans.xyz/temperature//api.php/Index/index?u_id=8&lat=0&long=0&a_id=166
    
    NSString *cachePath = [[OOCacheManager sharedInstance] OOKitPath];
    LxPrintf(@"cachePath = %@",cachePath);
    
    
    [[OOHttpManager sharedInstance] networkStatusWithBlock:^(AFNetworkReachabilityStatus status, NSString *netState) {
        
    }];
    
    
    
    // Override point for customization after application launch.
    return YES;
}



@end
