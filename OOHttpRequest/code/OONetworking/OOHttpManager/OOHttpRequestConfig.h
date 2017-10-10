//
//  OOHttpRequestConfig.h
//  链式网络请求
//
//  Created by feng on 2017/9/15.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OORequestMethod) {
    /** GET */
    OORequestMethodGET = 1,
    /** POST */
    OORequestMethodPOST,
    /** UPLOAD */
    OORequestMethodUPLOAD,
    /** DOWNLOAD */
    OORequestMethodDOWNLOAD
};



@interface OOHttpRequestConfig : NSObject

//默认配置
+ (instancetype)defultCongfig;

@property (nonatomic,copy) NSString * baseUrl;

//请求地址
@property (nonatomic, copy) NSString * url;

//请求地址说明
@property (nonatomic, copy) NSString * urlExplain;

//请求方式
@property (nonatomic, assign) OORequestMethod  method;

//请求参数
@property (nonatomic, strong) NSDictionary * param;

// 是否打印log信息
@property (nonatomic, assign) BOOL  log;

// 需要处理的数据数组
@property (nonatomic, strong) NSArray * dataArray;

/**********************  上传图片  ******************************/
// 需要上传的图片data数组
@property (nonatomic, strong) NSArray * imageDatas;
// 服务器对应的图片的key
@property (nonatomic, copy) NSString * attach;

/**********************  缓存  ******************************/
//是否缓存数据
@property (nonatomic, assign) BOOL  cache;

// 缓存过期时间 默认： 60*60*24*7
@property (nonatomic,assign) NSTimeInterval cacheMaxAge;

// 同一个请求间隔多长时间才能重新请求（用于缓存） 默认：30s
@property (nonatomic,assign) NSTimeInterval requestMinTime;


/**********************  HUD  ******************************/

@property (nonatomic, assign) BOOL  hud;

@property (nonatomic,copy) NSString * loadingMsg;

@property (nonatomic,copy) NSString * succMsg;

@property (nonatomic,copy) NSString * failureMsg;


//链式编程体验
- (OOHttpRequestConfig *(^)(BOOL isHud))isHud;

- (OOHttpRequestConfig *(^)(NSString * string))loadingmsg;

- (OOHttpRequestConfig *(^)(NSString * string))succmsg;

- (OOHttpRequestConfig *(^)(NSString * string))failuremsg;


- (OOHttpRequestConfig *(^)(NSString * string))urlStr;

- (OOHttpRequestConfig *(^)(NSString * string))explain;


- (OOHttpRequestConfig *(^)(NSString * string))baseURL;


- (OOHttpRequestConfig *(^)(OORequestMethod methodType))methodType;

- (OOHttpRequestConfig *(^)(BOOL isCache))isCache;

- (OOHttpRequestConfig *(^)(BOOL isLog))isLog;



- (OOHttpRequestConfig *(^)(NSDictionary *parameters))parameters;

- (OOHttpRequestConfig *(^)(NSArray * array))array;

- (OOHttpRequestConfig *(^)(NSArray * images))images;

- (OOHttpRequestConfig *(^)(NSString *imageKey))imageKey;


- (OOHttpRequestConfig *(^)(NSTimeInterval  time))cachetime;

- (OOHttpRequestConfig *(^)(NSTimeInterval  time))requesttime;



@end




