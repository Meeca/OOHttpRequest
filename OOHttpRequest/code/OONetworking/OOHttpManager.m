//
//  OOHttpManager.m
//  链式网络请求
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "OOHttpManager.h"
#import "XHToast.h"

static NSString *privateNetworkBaseUrl = nil;

@interface OOHttpManager ()

@end


@implementation OOHttpManager

OOHttpSingletonM
/*!
 *  @param baseUrl 网络接口的基础url
 */

- (void)setBaseUrl:(NSString *)baseUrl{
    _baseUrl = baseUrl;
    privateNetworkBaseUrl = baseUrl;

}

+ (NSString *)baseUrl {
    return privateNetworkBaseUrl;
}

#pragma mark - Private
+ (AFHTTPSessionManager *)managerBaseUrl:(NSString *)baseUrl {
    
    AFHTTPSessionManager *manager = nil;
    
    if (baseUrl) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    }else{
        if ([OOHttpManager baseUrl] != nil) {
            manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[OOHttpManager baseUrl]]];
        } else {
            manager = [AFHTTPSessionManager manager];
        }
    }
    
    [self uuuu];
    
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*",
                                                                              @"application/x-www-form-urlencoded"]];
    
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 9;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSString* headerCookie = [[NSUserDefaults standardUserDefaults]objectForKey:@"kAccess_tokenUserDefaults"];
    if(headerCookie!=nil&& headerCookie.length>0) {
        NSString * access_token =  [NSString stringWithFormat:@"access_token=%@",headerCookie];
        [manager.requestSerializer setValue:access_token forHTTPHeaderField:@"Cookie"];
    }
    return manager;
}

+ (NSString *)urlString:(NSString *)urlString appendingParameters:(id)parameters{
    if (parameters==nil) {
        return urlString;
    }else{
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSString *key in parameters) {
            id obj = [parameters objectForKey:key];
            NSString *str = [NSString stringWithFormat:@"%@=%@",key,obj];
            [array addObject:str];
        }
        
        NSString *parametersString = [array componentsJoinedByString:@"&"];
        return  [urlString stringByAppendingString:[NSString stringWithFormat:@"?%@",parametersString]];
    }
}



+ (void)uuuu{

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
        //未知网络 NSLog(@"未知网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable: {
                //无法联网
                NSLog(@"无法联网");
                
                
                [XHToast showCenterWithText:@"无法联网"];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                //手机自带网络
                NSLog(@"当前使用的是2g/3g/4g网络");
                
                [XHToast showCenterWithText:@"当前使用的是2g/3g/4g网络"];

            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                //WIFI
                NSLog(@"当前在WIFI网络下");
                
                [XHToast showCenterWithText:@"当前在WIFI网络下"];

            }
        }
    }];
    
}


#pragma mark  请求前统一处理：如果是没有网络，则不论是GET请求还是POST请求，均无需继续处理
+ (BOOL)examineNetwork {
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isNetworkEnable  =(isReachable && !needsConnection) ? YES : NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible =isNetworkEnable;/*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
    });
    return isNetworkEnable;
}



@end
