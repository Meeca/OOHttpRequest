//
//  OOHttpAnalysis.m
//  链式网络请求
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "OOHttpAnalysis.h"
#import "OOHttpRequest.h"
#import "OOHttpCacheRequest.h"
#import <LxDBAnything/LxDBAnything.h>

@interface OOHttpAnalysis()

@property (nonatomic, strong) OOHttpRequestConfig *config;


@end

@implementation OOHttpAnalysis

OOHttpSingletonM
/*!
 *  请求数据并且进一步解析
 *  @param block    请求配置
 *  @param progress    加载进度的回调
 *  @param cacheSuccess    缓存数据成功的回调
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
- (NSURLSessionTask *)requestWithConfig:( void (^)(OOHttpRequestConfig *config))block
                               progress:( void (^)(float progress))progress
                           cacheSuccess:( void (^)(id responseObject,NSString * msg))cacheSuccess
                                success:( void (^)(id responseObject,NSString * msg))success
                                failure:( void (^)(NSString * error,NSInteger code))failure{

    if (block) {
        block(self.config);
    }

    NSURLSessionTask *session  = [[OOHttpCacheRequest alloc] requestWithConfig:^(OOHttpRequestConfig *config) {
        
        config.url          =   self.config.url;
        config.baseUrl      =   self.config.baseUrl;
        config.param        =   self.config.param;
        config.method       =   self.config.method;
        config.attach       =   self.config.attach;
        config.imageDatas   =   self.config.imageDatas;
        config.cache        =   self.config.cache;
        config.dataArray    =   self.config.dataArray;
        config.log          =   self.config.log;


    }  progress:^(float progres) {
        
        progress(progres);
        
    } cacheSuccess:^(id responseObjects) {
        
        [self returnResponseObject:responseObjects success:cacheSuccess failure:failure];
        
    } success:^(id responseObject) {
        
        [self returnResponseObject:responseObject success:success failure:failure];
        
    } failure:^(NSString *error) {
        failure(error,404);
    }];
    
    return session;

}


- (void)returnResponseObject:(id )responseObject
                     success:( void (^)(id respons,NSString * msg))success
                     failure:( void (^)(NSString * error,NSInteger code))failure{
        
    if (responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([result isKindOfClass:[NSDictionary  class]]) {
            
            NSDictionary *  requestDic = (NSDictionary *)result;
            
            [self logInfoWith:requestDic];
            
            NSString *  msg = requestDic[@"msg"];
            NSString *  code = [NSString stringWithFormat:@"%@",requestDic[@"code"]];
            NSDictionary * info =requestDic[@"data"];
            
            if ([code isEqualToString:@"0"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(info,msg);
                });
            }else{
                failure(msg,[code integerValue]);
            }
        }
    }
    
}

- (OOHttpRequestConfig *)config {
    if (_config == nil) {
        _config = [OOHttpRequestConfig defultCongfig];
    }
    return _config;
}


- (void)logInfoWith:(id)info{
    
    
#ifdef DEBUG
    BOOL log = self.config.log;
    if (log) {
       printf("\n\nOOHttpAnalysis\n网络请求数据\n📍\n%s\n📍\n", [[NSString stringWithFormat:@"%@", info] UTF8String]);
    }
#else
#endif
}




@end
