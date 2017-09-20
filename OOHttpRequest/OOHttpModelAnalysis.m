//
//  OOHttpModelAnalysis.m
//  链式网络请求
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "OOHttpModelAnalysis.h"
#import "OOHttpAnalysis.h"
#import <YYModel/YYModel.h>
#import "ConsultModel.h"


@interface OOHttpModelAnalysis()

@property (nonatomic, strong) OOHttpRequestConfig *config;


@property (strong, nonatomic) NSArray * cacheArray;

@end

@implementation OOHttpModelAnalysis

OOHttpSingletonM

- (NSURLSessionTask *)requestConfig:(void(^)(OOHttpRequestConfig *configs))block
                        cacheSuccess:( void (^)(NSArray * dataArray))cacheSuccess
                             success:( void (^)(NSArray * dataArray,NSString * msg))success
                             failure:( void (^)(NSString * error,NSInteger code))failure{
    
    if (block) {
        block(self.config);
    }
    
    NSMutableArray * dataSource = [NSMutableArray arrayWithArray:self.config.dataArray];
    
    __block NSArray * cacheArray = nil;
    
    NSURLSessionTask *session = [[OOHttpAnalysis sharedInstance]  requestConfig:^(OOHttpRequestConfig *config) {
        
        config = self.config;
        
    }  progress:^(float progres) {
        
        
        
    } cacheSuccess:^(id responseObject, NSString *msg) {
        
        NSDictionary * result = (NSDictionary *)responseObject;
        
        
        NSLog(@"---缓存-\n\n%@\n\n",result);
        
        // 缓存数据
        NSArray * array = [NSArray yy_modelArrayWithClass:[ConsultModel class] json:result[@"rows"]];
        
        cacheArray = array;
        
        [dataSource addObjectsFromArray:array];
        
        cacheSuccess(dataSource);
        
        _cacheArray = dataSource;
        
        
    } success:^(id responseObject, NSString *msg) {
        
        // 当缓存数据和网络数据不一致时，会返回网络数据
        
        [dataSource removeObjectsInArray:cacheArray];
        
        NSDictionary * result = (NSDictionary *)responseObject;
        
        NSLog(@"---网络---\n\n%@\n\n",result);
        
        NSArray * array = [NSArray yy_modelArrayWithClass:[ConsultModel class] json:result[@"rows"]];
        
        [dataSource addObjectsFromArray:array];
        
        success(dataSource,msg);
        
        
    } failure:^(NSString *error, NSInteger code) {
        failure(error,code);
    }];
    
    return session;
    
}

- (OOHttpRequestConfig *)config {
    if (_config == nil) {
        _config = [OOHttpRequestConfig defultCongfig];
    }
    return _config;
}


@end
