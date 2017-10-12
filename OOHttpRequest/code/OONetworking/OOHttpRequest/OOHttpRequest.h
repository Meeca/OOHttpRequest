//
//  OOHttpRequest.h
//  链式网络请求
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOHttpSingleton.h"
#import "OOHttpRequestConfig.h"

@interface OOHttpRequest : NSObject

/**********************   POST    ****************************/

/*!
 *  POST请求 不缓存数据
 *
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
- (NSURLSessionTask *)requestConfig:( void (^)(OOHttpRequestConfig *config))block
                               progress:( void (^)(float progres))progress
                                success:( void (^)(id responseObject))success
                                failure:( void (^)(NSString * error))failure;

/**
 *  取消所有网络请求
 */
+ (void)cancelAllRequest;
/**
 *  取消这个url对应的网络请求
 */
+ (void)cancelRequestWithURL:(NSString *)url;



@end
