//
//  OOHttpAnalysis.h
//  链式网络请求
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOHttpSingleton.h"
#import "OOHttpRequestConfig.h"

@interface OOHttpAnalysis : NSObject

OOHttpSingletonH

/*!
 *  请求数据并且进一步解析
 *  @param block    请求配置
 *  @param progress    加载进度的回调
 *  @param cacheSuccess    缓存数据成功的回调
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
- (NSURLSessionTask *)requestWithConfig:(void(^)(OOHttpRequestConfig *config))block
                               progress:( void (^)(float progress))progress
                           cacheSuccess:( void (^)(id responseObject,NSString * msg))cacheSuccess
                                success:( void (^)(id responseObject,NSString * msg))success
                                failure:( void (^)(NSString * error,NSInteger code))failure;





@end
