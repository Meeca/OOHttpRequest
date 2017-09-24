//
//  OOHttpCacheRequest.m
//  链式网络请求
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "OOHttpCacheRequest.h"
#import "OOHttpManager.h"
#import "OOHttpRequest.h"
#import "OOCacheManager.h"


@interface OOHttpCacheRequest()

@property (nonatomic, strong) OOHttpRequestConfig *config;

@end

@implementation OOHttpCacheRequest


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
                                failure:( void (^)(NSString * error))failure{


    if (block) {
        block(self.config);
    }

    NSString * url = self.config.url;
    NSDictionary * param = self.config.param;
    BOOL cache = self.config.cache;
    
    __block id response = nil;
    NSString * urlKey = [OOHttpManager urlString:url appendingParameters:param];
    
    
    if (cache) {
        
        // 如果缓存文件的创建时间与本次请求间隔时间 大于 timeOut 并且网络畅通,那么说明缓存文件过去，不在使用缓存
        if ([self isTimeOutWithUrl:urlKey]) {
            // 清除过期的缓存文件
            [[OOCacheManager sharedInstance] clearCacheForkey:urlKey];
            
        }else{
            
            [[OOCacheManager sharedInstance] getCacheDataForKey:urlKey value:^(id responseObj, NSString *filePath) {
                
                response  = responseObj;
                cacheSuccess(response);
            }];
        }
        
        // 如果缓存文件的创建时间与本次请求间隔时间 少于 timeOut ,那么忽略本次请求
        if ([self isTimeInWithUrl:urlKey]) {
            return nil;
        }
        
    }
    
    NSURLSessionTask * session = nil;
    session= [[OOHttpRequest sharedInstance] requestConfig:^(OOHttpRequestConfig *config) {
        
        config.url          = self.config.url;
        config.baseUrl      = self.config.baseUrl;
        config.param        = self.config.param;
        config.method       = self.config.method;
        config.attach       = self.config.attach;
        config.imageDatas   = self.config.imageDatas;
        config.cache        = self.config.cache;
        config.log          = self.config.log;
        config.urlExplain   = self.config.urlExplain;

        
    } progress:^(float progres) {
        
        progress(progres);
        
    } success:^(id responseObject) {
        
        if (cache) {
            BOOL same = [self judgeCacheDataIsSameWithCache:response netData:responseObject];
            
            [[OOCacheManager sharedInstance] storeContent:responseObject forKey:urlKey];
            NSLog(@"%@",same?@"缓存数据和网络数据一致":@"数据不一致");
            // 如果缓存数据和网络数据不一致，返回数据，
            if (!same) {
                success(responseObject);
            }
        }else{
            
            success(responseObject);
        }
    } failure:^(NSString *error) {
        failure(error);
    }];
    return session;

}

/*!
 *  判断网络数据和缓存数据是否相同
 *
 *  @param response     缓存数据
 *  @param responseObject 网络数据
 */

- (BOOL )judgeCacheDataIsSameWithCache:(id)response netData:(id )responseObject{

    NSString * resultCache = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSString * resultNet = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSString * resultCacheMD5 = [[OOCacheManager sharedInstance] MD5StringForKey:resultCache];
    NSString * resultNetMD5 = [[OOCacheManager sharedInstance] MD5StringForKey:resultNet];

    if ([resultCacheMD5 isEqualToString: resultNetMD5]) {
        return YES;
    }
    return NO;
}



// 对比本地和网络数据  !!!!!!!!!!!!!!!!!!!!!!!!!

// 判断文件是否过期
- (BOOL )isTimeOutWithUrl:(NSString *)url{

    NSTimeInterval  cacheMaxAge = self.config.cacheMaxAge;
    
    if (!cacheMaxAge || cacheMaxAge==0) {
        return NO;
    }
    
    NSTimeInterval  time = [self isTimeOutWithPath:url];
    // 如果缓存文件的创建时间与本次请求间隔时间 大于 timeOut 并且网络畅通,那么说明缓存文件过期
    if(time > cacheMaxAge && [OOHttpManager examineNetwork]){
        return YES;
    }
    return NO;
}
// 判断是否忽略本次请求
- (BOOL )isTimeInWithUrl:(NSString *)url{
    
   NSTimeInterval  requestMinTime =  self.config.requestMinTime;
    
    if (!requestMinTime || requestMinTime == 0) {
        return NO;
    }
    NSTimeInterval  time = [self isTimeOutWithPath:url];
    
    if(time <  requestMinTime){
        return YES;
    }
    return NO;
}




// 如果缓存文件的创建时间与本次请求间隔时间
- (NSTimeInterval )isTimeOutWithPath:(NSString *) url{

    // 获取当前url缓存文件的路径
    NSString * cachePath = [[[OOCacheManager sharedInstance] OOAppCachePath] stringByAppendingString:@"/"];
    
    NSString * path = [cachePath stringByAppendingString:[[OOCacheManager sharedInstance] MD5StringForKey:url]];
    
    NSDictionary *info = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    
    NSDate *current = [info objectForKey:NSFileModificationDate];
    
    NSDate *date = [NSDate date];
    
    // 缓存文件的创建时间距离本次发起请求的间隔时间
    NSTimeInterval currentTime = [date timeIntervalSinceDate:current];

    return currentTime;
        
}

- (OOHttpRequestConfig *)config {
    if (_config == nil) {
        _config = [OOHttpRequestConfig defultCongfig];
    }
    return _config;
}




@end
