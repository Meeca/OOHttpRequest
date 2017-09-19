//
//  OOHttpModelAnalysis.h
//  链式网络请求
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOHttpSingleton.h"
#import "OOHttpRequestConfig.h"

@interface OOHttpModelAnalysis : NSObject


OOHttpSingletonH


- (NSURLSessionTask *)requestWithConfig:(void(^)(OOHttpRequestConfig *config))block
                        cacheSuccess:( void (^)(NSArray * dataArray))cacheSuccess
                             success:( void (^)(NSArray * dataArray,NSString * msg))success
                             failure:( void (^)(NSString * error,NSInteger code))failure;




@end

















