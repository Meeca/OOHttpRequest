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
#import "OOHudTools.h"
#import "OOHttpManager.h"

@interface OOHttpAnalysis()

@property (nonatomic, strong) OOHttpRequestConfig *config;

@end

@implementation OOHttpAnalysis


/*!
 *  请求数据并且进一步解析
 *  @param block    请求配置
 *  @param progress    加载进度的回调
 *  @param cacheSuccess    缓存数据成功的回调
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
- (NSURLSessionTask *)requestConfig:( void (^)(OOHttpRequestConfig *config))block
                               progress:( void (^)(float progres))progress
                           cacheSuccess:( void (^)(id responseObject,NSString * msg))cacheSuccess
                                success:( void (^)(id responseObject,NSString * msg))success
                                failure:( void (^)(NSString * error,NSInteger code))failure{

    
    
    self.config = nil;
    
    if (block) {
        block(self.config);
    }
    [self loading];
    
    NSURLSessionTask *session  = [[OOHttpCacheRequest alloc] requestConfig:^(OOHttpRequestConfig *config) {
        
        config.url          =   self.config.url;
        config.urlExplain   =   self.config.urlExplain;
        config.baseUrl      =   self.config.baseUrl;
        config.param        =   self.config.param;
        config.method       =   self.config.method;
        config.attach       =   self.config.attach;
        config.imageDatas   =   self.config.imageDatas;
        config.cache        =   self.config.cache;
        config.log          =   self.config.log;

    }  progress:^(float progres) {
        
        progress(progres);
        
    } cacheSuccess:^(id responseObjects) {
        
        [self returnResponseObject:responseObjects cache:YES success:cacheSuccess failure:failure];
        
    } success:^(id responseObject) {
        
        [self returnResponseObject:responseObject cache:NO success:success failure:failure];
        
    } failure:^(NSString *error) {
        
        [self failureMsg:error];
        
        failure(error,404);
    }];
    
    return session;

}


- (void)returnResponseObject:(id )responseObject
                       cache:(BOOL )cache
                     success:( void (^)(id respons,NSString * msg))success
                     failure:( void (^)(NSString * error,NSInteger code))failure{
        
    if (responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if([result isKindOfClass:[NSDictionary  class]]) {
            
            NSDictionary *  requestDic = (NSDictionary *)result;
            
            [self logInfoWith:requestDic cache:cache];
            
            NSString *  msg = requestDic[@"msg"];
            NSString *  code = [NSString stringWithFormat:@"%@",requestDic[@"code"]];
            NSDictionary * info =requestDic[@"data"];
            
            if ([code isEqualToString:@"0"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    cache?[OOHudTools hide]:[self successMsg:msg];
                    success(info,msg);
                });
            }else{
                
                cache?@"":[self failureMsg:msg];
                
                failure(msg,[code integerValue]);
            }
        }
    }
    
}

- (OOHttpRequestConfig *)config {
    if (_config == nil) {
        _config = [OOHttpRequestConfig  defultCongfig];
    }
    return _config;
}


- (void)loading{

    BOOL hud = self.config.hud;
    NSString * loading = self.config.loadingMsg;
    if (hud) {
        if (loading) {
            [OOHudTools showLoadingWithtitle:loading];
        }else{
            [OOHudTools showLoading];
        }
    }
}

- (void)successMsg:(NSString *)message{

    BOOL hud = self.config.hud;
    NSString * msg = self.config.succMsg;

    if (hud) {
        if (msg) {
            [OOHudTools showSuccessStatusWithtitle:msg];
         }else{
             [OOHudTools showSuccessStatusWithtitle:message];
        }
    }
}

- (void)failureMsg:(NSString *)error{
    
    BOOL hud = self.config.hud;
    NSString * msg = self.config.failureMsg;
    if (hud) {
        if (msg) {
            [OOHudTools showErrorStatusWithtitle:msg];
        }else{
            [OOHudTools showErrorStatusWithtitle:error];
        }
    }
}

- (void)logInfoWith:(id)info cache:(BOOL)cache{
#ifdef DEBUG
    BOOL log = self.config.log;
    if (log) {
        
        NSString * urls = [[OOHttpManager sharedInstance].baseUrl stringByAppendingString:self.config.url];
        NSString * urlstr = [OOHttpManager urlString:urls appendingParameters:self.config.param];
        NSString * explain = self.config.urlExplain?self.config.urlExplain:@"请求地址";
        NSString * msg = cache?@"缓存数据":@"网络请求数据";
        NSString * infostr = [NSString stringWithFormat:@"%@", info];
        
        printf("\n🍏\n🍏🍎🍏 %s  👉🌐  %s\n🍏👉🍏 %s\n👇👇👇👇👇👇👇👇👇👇👇👇👇👇\n%s\n👆👆👆👆👆👆👆👆👆👆👆👆👆👆\n",[[NSString stringWithFormat:@"%@", explain] UTF8String], [[NSString stringWithFormat:@"%@", urlstr] UTF8String],[msg UTF8String],[infostr UTF8String]);
    }
#else
#endif
}

@end
