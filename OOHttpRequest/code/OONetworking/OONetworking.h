//
//  OONetworking.h
//  链式网络请求
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#ifndef OONetworking_h
#define OONetworking_h

#import "OOHttpManager.h"           // AFHTTPSessionManager 设置
#import "OOHttpRequest.h"           // 网络请求
#import "OOHttpCacheRequest.h"      // 带缓存的网络请求
#import "OOHttpAnalysis.h"          // 带初步解析json数据的网络请求
#import "OOChainedHttpRequest.h"    // 链式网络请求
#import "OOCacheManager.h"          // 缓存管理


#ifdef DEBUG
#define OOLog(...) printf("\n%s\n", [[NSString stringWithFormat:__VA_ARGS__] UTF8String]); //如果不需要打印数据，把这__  OOLog(__VA_ARGS__) ___注释了
#else
#define OOLog(...)
#endif




#endif /* OONetworking_h */


/**
 
 #import "OONetworking.h"    
 
 
 OOHttpCacheRequest 
     
    * 会判断缓存数据是否跟请求到的数据一样
    * 如果数据一样，会更新数据，且 不会再返回网络数据
 
 
 OOHttpAnalysis
 
    * 初步解析出页面所需要的的json数据
    * 统一根据api返回的状态码判断此次请求是否正确
 
 OOChainedHttpRequest
    
    * 根据 OOHttpAnalysis 进行再次封装成链式调用
    * 加载进度、缓存结果、网络数据结果、错误信息 均为可选项
 
 
 NSMutableDictionary * params = [NSMutableDictionary new];
 params[@"cid"] = @"2";
 
 [OORequest requestWithConfig:^(OOHttpRequestConfig *config) {
 
     config.url = @"/api/news/getList/cid";
     config.param = params;
     config.dataArray = _dataArray;
     config.cache = YES;
 
 }].cachesuccess(^(id responseObject,NSString * msg){
 
 
 
 
 }).success(^(id responseObject,NSString * msg){
 
 
 }).failure(^(NSString * error){
 
 
 }).startRequest();

 
 
 
 */

