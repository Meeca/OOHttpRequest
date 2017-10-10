
//
//  OOHttpRequest.m
//  链式网络请求
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "OOHttpRequest.h"
#import "OOHttpManager.h"
#import "AFNetworking.h"
#import "XHToast.h"

static NSMutableArray *requestTasks;

@interface OOHttpRequest()

@property (nonatomic, strong) OOHttpRequestConfig *config;

@end

@implementation OOHttpRequest


- (NSURLSessionTask *)requestConfig:( void (^)(OOHttpRequestConfig *config))block
                               progress:( void (^)(float progres))progress
                                success:( void (^)(id responseObject))success
                                failure:( void (^)(NSString * error))failure{

    
    if (block) {
        block(self.config);
    }
    
    NSString * url          = self.config.url;              // 请求地址
    NSString * baseUrl      = self.config.baseUrl;          // 请求域名地址
    NSDictionary * param    = self.config.param;            // 请求参数
    OORequestMethod  method = self.config.method;           // 请求方式

    if(![OOHttpManager examineNetwork]){
        failure(@"网络开小差了");
        [XHToast showCenterWithText:@"网络错误"];
        return nil;
    }
    
    if([url isEqualToString:@""]||url==nil)return nil;
    if (![url isKindOfClass:NSString.class]) {
        url = nil;
    }
    
    [self logInfoWithUrl:url withParame:param];
    
    AFHTTPSessionManager * manager = [OOHttpManager managerBaseUrl:baseUrl];

    
    NSURLSessionTask *session = nil;

    switch (method) {
        case OORequestMethodGET:
        {
            session = [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
                
                float myProgress = (float)downloadProgress.completedUnitCount / (float)downloadProgress.totalUnitCount;
                progress(myProgress);
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                success(responseObject);
                
                [self removeTaskWithTask:task];
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                failure([error description]);
                
                [self removeTaskWithTask:task];
            }];
        }
            break;
        case OORequestMethodPOST:
        {
            session = [manager POST:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
                
                float myProgress = (float)downloadProgress.completedUnitCount / (float)downloadProgress.totalUnitCount;
                progress(myProgress);
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                success(responseObject);
                
                [self removeTaskWithTask:task];
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                failure([error description]);
                
                [self removeTaskWithTask:task];
            }];
        }
            break;
        case OORequestMethodUPLOAD:
        {
            
            NSArray * imagDatas = self.config.imageDatas;
            NSString * attach = self.config.attach;;
            
            session = [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                for (NSInteger i=0; i < imagDatas.count; i++) {
                    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
                    NSString * fileName =[NSString stringWithFormat:@"%@_%ld.png",@(timeInterval),i];
                    // 上传图片，以文件流的格式
                    [formData appendPartWithFileData:imagDatas[i] name:attach fileName:fileName mimeType:@"image/png"];
                }
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                float myProgress = (float)uploadProgress.completedUnitCount / (float)uploadProgress.totalUnitCount;
                progress(myProgress);
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                success(responseObject);
                
                [self removeTaskWithTask:task];
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                failure([error description]);
                [self removeTaskWithTask:task];
                
            }];
        }
            break;
            
        default:
            break;
    }


    if (session) {
        [[self allTasks] addObject:session];
    }
    return session;
}


/**
 *  取消网络请求 并且关闭网络指示器
 */
- (void)removeTaskWithTask:(NSURLSessionDataTask *)task{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
    [[self allTasks] removeObject:task];
}

- (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasks == nil) {
            requestTasks = [[NSMutableArray alloc] init];
        }
    });
    return requestTasks;
}

/**
 *  取消所有网络请求
 */
+ (void)cancelAllRequest {
    @synchronized(self) {
        [[[self alloc] allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]) {
                [task cancel];
            }
        }];
        [[[self alloc] allTasks] removeAllObjects];
    };
}
/**
 *  取消这个url对应的网络请求
 */
+ (void)cancelRequestWithURL:(NSString *)url {
    if (url == nil) {
        return;
    }
    @synchronized(self) {
        [[[self alloc] allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[[self alloc] allTasks] removeObject:task];
                return;
            }
        }];
    };
}


- (OOHttpRequestConfig *)config {
    if (_config == nil) {
        _config = [OOHttpRequestConfig  defultCongfig];
    }
    return _config;
}

- (void)logInfoWithUrl:(NSString *)url withParame:(id)parame{
    
#ifdef DEBUG
    BOOL log = self.config.log;
    if (log) {
        NSString * urls = [[OOHttpManager sharedInstance].baseUrl stringByAppendingString:url];
        NSString * urlstr = [OOHttpManager urlString:urls appendingParameters:parame];
        NSString * explain = self.config.urlExplain?self.config.urlExplain:@"请求地址";
        printf("\n📍\n🎈   %s \n--->  %s\n📍",[[NSString stringWithFormat:@"%@", explain] UTF8String], [[NSString stringWithFormat:@"%@", urlstr] UTF8String]);
    }
#else
#endif
}





@end
