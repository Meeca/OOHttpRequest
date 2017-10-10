
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
    config.cache                = NO;
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

- (OOHttpRequestConfig *(^)(NSString * string))explain{
    return ^OOHttpRequestConfig * (NSString * string) {
        self.urlExplain = string;
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




#pragma mark - NSDictionary,NSArray,NSSet 的分类
/*
 ************************************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
 ************************************************************************************
 */

#ifdef DEBUG
@implementation NSArray (OOHttp)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    
    NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [tabString appendString:@"\t"];
    }
    
    NSString *tab = @"";
    if (level > 0) {
        tab = tabString;
    }
    [desc appendString:@"\t(\n"];
    
    for (id obj in self) {
        if ([obj isKindOfClass:[NSDictionary class]]
            || [obj isKindOfClass:[NSArray class]]
            || [obj isKindOfClass:[NSSet class]]) {
            NSString *str = [((NSDictionary *)obj) descriptionWithLocale:locale indent:level + 1];
            [desc appendFormat:@"%@\t%@,\n", tab, str];
        } else if ([obj isKindOfClass:[NSString class]]) {
            [desc appendFormat:@"%@\t\"%@\",\n", tab, obj];
        } else {
            [desc appendFormat:@"%@\t%@,\n", tab, obj];
        }
    }
    
    [desc appendFormat:@"%@)", tab];
    
    return desc;
}


@end

@implementation NSDictionary (OOHttp)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    
    NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [tabString appendString:@"\t"];
    }
    
    NSString *tab = @"";
    if (level > 0) {
        tab = tabString;
    }
    
    [desc appendString:@"\t{\n"];
    
    // 遍历数组,self就是当前的数组
    for (id key in self.allKeys) {
        id obj = [self objectForKey:key];
        
        if ([obj isKindOfClass:[NSString class]]) {
            [desc appendFormat:@"%@\t%@ = \"%@\",\n", tab, key, obj];
        } else if ([obj isKindOfClass:[NSArray class]]
                   || [obj isKindOfClass:[NSDictionary class]]
                   || [obj isKindOfClass:[NSSet class]]) {
            [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, [obj descriptionWithLocale:locale indent:level + 1]];
        } else {
            [desc appendFormat:@"%@\t%@ = %@,\n", tab, key, obj];
        }
    }
    
    [desc appendFormat:@"%@}", tab];
    
    return desc;
}

@end

@implementation NSSet (OOHttp)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    
    NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [tabString appendString:@"\t"];
    }
    
    NSString *tab = @"\t";
    if (level > 0) {
        tab = tabString;
    }
    [desc appendString:@"\t{(\n"];
    
    for (id obj in self) {
        if ([obj isKindOfClass:[NSDictionary class]]
            || [obj isKindOfClass:[NSArray class]]
            || [obj isKindOfClass:[NSSet class]]) {
            NSString *str = [((NSDictionary *)obj) descriptionWithLocale:locale indent:level + 1];
            [desc appendFormat:@"%@\t%@,\n", tab, str];
        } else if ([obj isKindOfClass:[NSString class]]) {
            [desc appendFormat:@"%@\t\"%@\",\n", tab, obj];
        } else {
            [desc appendFormat:@"%@\t%@,\n", tab, obj];
        }
    }
    
    [desc appendFormat:@"%@)}", tab];
    
    return desc;
}

@end



#endif




