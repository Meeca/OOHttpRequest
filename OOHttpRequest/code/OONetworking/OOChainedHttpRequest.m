//
//  OOChainedHttpRequest.m
//  链式网络请求
//
//  Created by feng on 2017/9/18.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "OOChainedHttpRequest.h"
#import "OOHttpAnalysis.h"

@interface OOChainedHttpRequest()

@property (nonatomic, strong) OOHttpRequestConfig *config;

@end

@implementation OOChainedHttpRequest

OOHttpSingletonM

- (OOChainedHttpRequest *)requestConfig:( void (^)(OOHttpRequestConfig *config))block{
    if (block) {
        block(self.config);
    }
    return self;
}

- (OOChainedHttpRequest *(^)())startRequest {
    return ^() {
        [self startRequestAPIWithRecorder:_config];
        return self;
    };
}

- (void)startRequestAPIWithRecorder:(OOHttpRequestConfig *)configs {
    
    [[OOHttpAnalysis sharedInstance] requestConfig:^(OOHttpRequestConfig *config) {
        
        config.url          = configs.url;
        config.urlExplain   = configs.urlExplain;
        config.baseUrl      = configs.baseUrl;
        config.param        = configs.param;
        config.method       = configs.method;
        config.cache        = configs.cache;
        config.imageDatas   = configs.imageDatas;
        config.attach       = configs.attach;
        config.log          = configs.log;

        config.hud          = configs.hud;
        config.succMsg      = configs.succMsg;
        config.loadingMsg   = configs.loadingMsg;
        config.failureMsg   = configs.failureMsg;
        
        
    } progress:^(float progres) {
        
        if (_oo_progress) {
            _oo_progress(progres);
        }
        
    } cacheSuccess:^(id responseObject, NSString *msg) {
        
        if (_oo_cacheData) {
            _oo_cacheData(responseObject);
        }
        
    } success:^(id responseObject, NSString *msg) {
        
        if (_oo_success) {
            _oo_success(responseObject,msg);
        }
        
    } failure:^(NSString *error, NSInteger code) {
        if (_oo_failure) {
            _oo_failure(error,code);
        }
    }];
}
    



- (OOChainedHttpRequest *(^)(OOSuccess))success {
    return ^(OOSuccess success) {
        self.oo_success = success;
        return self;
    };
}

- (OOChainedHttpRequest *(^)(OOCacheData cacheData))cacheData{
    return ^(OOCacheData cacheData) {
        self.oo_cacheData = cacheData;
        return self;
    };
}

- (OOChainedHttpRequest *(^)(OOFailure))failure {
    return ^(OOFailure failure) {
        self.oo_failure = failure;
        return self;
    };
}

- (OOChainedHttpRequest *(^)(OOProgress))progress {
    return ^(OOProgress progress) {
        self.oo_progress = progress;
        return self;
    };
}

- (OOHttpRequestConfig *)config {
    if (_config == nil) {
        _config = [OOHttpRequestConfig defultCongfig];
    }
    return _config;
}


    


@end
