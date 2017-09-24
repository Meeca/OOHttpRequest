//
//  OOHttpManager.h
//  链式网络请求
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "OOHttpSingleton.h"

@interface OOHttpManager : NSObject

OOHttpSingletonH

/*!
 *   baseUrl 网络接口的基础url
 */



@property (nonatomic,copy) NSString * baseUrl;

+ (AFHTTPSessionManager *)managerBaseUrl:(NSString *)baseUrl;

+ (NSString *)urlString:(NSString *)urlString appendingParameters:(id)parameters;

+ (BOOL)examineNetwork;

- (void)networkStatusWithBlock:(void (^)(AFNetworkReachabilityStatus status,NSString * netState))networkStatus;

@end
