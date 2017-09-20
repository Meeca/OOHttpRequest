//
//  OOChainedHttpRequest.h
//  链式网络请求
//
//  Created by feng on 2017/9/18.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOHttpSingleton.h"
#import "OOHttpRequestConfig.h"

#define OORequest [OOChainedHttpRequest sharedInstance]


@class OOChainedHttpRequest;
//成功回调
typedef void(^OOSuccess)(id responseObj,NSString * msg);
typedef void(^OOCacheData)(id responseObj);
//失败回调
typedef void(^OOFailure)(NSString * error,NSInteger code);
//进度回调
typedef void(^OOProgress)(float progres);

@interface OOChainedHttpRequest : NSObject

OOHttpSingletonH

@property (copy, nonatomic) OOSuccess   oo_success;
@property (copy, nonatomic) OOCacheData oo_cacheData;
@property (copy, nonatomic) OOFailure   oo_failure;
@property (copy, nonatomic) OOProgress  oo_progress;


- (OOChainedHttpRequest *(^)(OOSuccess success))success;
- (OOChainedHttpRequest *(^)(OOCacheData cacheData))cacheData;
- (OOChainedHttpRequest *(^)(OOFailure failure))failure;
- (OOChainedHttpRequest *(^)(OOProgress progress))progress;
- (OOChainedHttpRequest *(^)())startRequest;//发起请求

- (OOChainedHttpRequest *)requestConfig:( void (^)(OOHttpRequestConfig *config))block;



@end
