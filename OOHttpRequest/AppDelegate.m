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
    
    
    [OOHttpManager sharedInstance].baseUrl = @"http://wuye.mcykj.com";
    
    
    NSString *cachePath = [[OOCacheManager sharedInstance] OOKitPath];
    LxPrintf(@"cachePath = %@",cachePath);
    
    // Override point for customization after application launch.
    return YES;
}

@end
