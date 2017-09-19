
//
//  OOHttpRequestConfig.m
//  链式网络请求
//
//  Created by feng on 2017/9/15.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "OOHttpRequestConfig.h"

@interface OOHttpRequestConfig()


@end

@implementation OOHttpRequestConfig

+ (instancetype)defultCongfig {
    OOHttpRequestConfig *config = [OOHttpRequestConfig new];
    config.method               = OORequestMethodPOST;
    config.cache                = YES;
    config.log                  = YES;
    config.cacheMaxAge          = 60*60*24*7;
    config.requestMinTime       = 30;
    return config;
}

- (OOHttpRequestConfig *(^)(NSString *))baseURL{
   
    return ^OOHttpRequestConfig * (NSString * string) {
        self.baseUrl = string;
        return self;
    };
}


- (OOHttpRequestConfig *(^)(NSString *))urlStr {

    return ^OOHttpRequestConfig * (NSString * string) {
        self.url = string;
        return self;
    };
}

- (OOHttpRequestConfig *(^)(OORequestMethod ))methodType{
 
    return ^OOHttpRequestConfig * (OORequestMethod methodType) {
        self.method = methodType;
        return self;
    };
}

- (OOHttpRequestConfig *(^)(BOOL isLog))isLog{

    return ^OOHttpRequestConfig * (BOOL isLog) {
        self.log = isLog;
        return self;
    };
}


- (OOHttpRequestConfig *(^)(BOOL isCache))isCache{
   
    return ^OOHttpRequestConfig * (BOOL isCache) {
        self.cache = isCache;
        return self;
    };
}

- (OOHttpRequestConfig *(^)(NSDictionary *))parameters {
   
    return ^OOHttpRequestConfig * (NSDictionary *parameters) {
        self.param = parameters;
        return self;
    };
}

- (OOHttpRequestConfig *(^)(NSArray * array))array{
    
    return ^OOHttpRequestConfig * (NSArray *array) {
        self.dataArray = array;
        return self;
    };
}

- (OOHttpRequestConfig *(^)(NSArray * images))images{
    return ^OOHttpRequestConfig * (NSArray *images) {
        self.imageDatas = images;
        return self;
    };

}
- (OOHttpRequestConfig *(^)(NSString *imageKey))imageKey{

    return ^OOHttpRequestConfig * (NSString *imageKey) {
        self.attach = imageKey;
        return self;
    };
}

- (OOHttpRequestConfig *(^)(NSTimeInterval  time))cachetime{

    return ^OOHttpRequestConfig * (NSTimeInterval time) {
        self.cacheMaxAge = time;
        return self;
    };

}

- (OOHttpRequestConfig *(^)(NSTimeInterval  time))requesttime{
    return ^OOHttpRequestConfig * (NSTimeInterval time) {
        self.requestMinTime = time;
        return self;
    };
    
}


- (OOHttpRequestConfig *(^)(BOOL isHud))isHud{

    return ^OOHttpRequestConfig * (BOOL isHud) {
        self.hud = isHud;
        return self;
    };
}

- (OOHttpRequestConfig *(^)(NSString *))loadingmsg{

    return ^OOHttpRequestConfig * (NSString * string) {
        self.loadingMsg = string;
        return self;
    };
}

- (OOHttpRequestConfig *(^)(NSString * string))succmsg{

    return ^OOHttpRequestConfig * (NSString * string) {
        self.succMsg = string;
        return self;
    };
}

- (OOHttpRequestConfig *(^)(NSString * string))failuremsg{

    return ^OOHttpRequestConfig * (NSString * string) {
        self.failureMsg = string;
        return self;
    };
}














@end







