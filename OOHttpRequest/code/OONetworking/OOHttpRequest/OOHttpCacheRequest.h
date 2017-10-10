//
//  OOHttpCacheRequest.h
//  链式网络请求
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOHttpRequestConfig.h"

@interface OOHttpCacheRequest : NSObject



/*!
 *  请求数据
 *  @param block    请求配置
 *  @param progress    加载进度的回调
 *  @param cacheSuccess    缓存数据成功的回调
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
- (NSURLSessionTask *)requestConfig:( void (^)(OOHttpRequestConfig *config))block
                               progress:( void (^)(float progres))progress
                           cacheSuccess:( void (^)(id responseObject))cacheSuccess
                                success:( void (^)(id responseObject))success
                                failure:( void (^)(NSString * error))failure;


@end
