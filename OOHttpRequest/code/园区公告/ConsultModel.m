
//
//  ConsultModel.m
//  wuye
//
//  Created by feng on 2017/8/17.
//  Copyright © 2017年 冯. All rights reserved.
//

#import "ConsultModel.h"
#import "OOHttpAnalysis.h"
#import <YYModel/YYModel.h>

@implementation ConsultModel



- (void)gardenNoticeInfowithPage:(NSInteger )page dataArray:(NSArray *)dataArray success:( void (^)(NSArray *modelArray))success{


    NSMutableArray * dataSource = [NSMutableArray arrayWithArray:dataArray];
    
    __block NSArray * cacheArray = nil;
    
    
    //   MVVM
    
    NSMutableDictionary * params = [NSMutableDictionary new];
    params[@"cid"] = @"2";

    [[OOHttpAnalysis sharedInstance] requestWithConfig:^(OOHttpRequestConfig *config) {
        
        config.url = @"/api/news/getList/cid";
        config.param = params;
        config.cache = YES;
        config.dataArray = dataArray;
        
        
    } progress:^(float progres) {
        
        
    } cacheSuccess:^(id responseObject, NSString *msg) {
        
        NSDictionary * result = (NSDictionary *)responseObject;
        
        // 缓存数据
        NSArray * array = [NSArray yy_modelArrayWithClass:[ConsultModel class] json:result[@"rows"]];
        
        cacheArray = array;
        
        [dataSource addObjectsFromArray:array];
        
        success(dataSource);
        
        
    } success:^(id responseObject, NSString *msg) {
        
        // 当缓存数据和网络数据不一致时，会返回网络数据
        
        [dataSource removeObjectsInArray:cacheArray];
        
        NSDictionary * result = (NSDictionary *)responseObject;
        
        NSArray * array = [NSArray yy_modelArrayWithClass:[ConsultModel class] json:result[@"rows"]];
        
        [dataSource addObjectsFromArray:array];
        
        success(dataSource);
        
        
    } failure:^(NSString *error, NSInteger code) {

    }];


}



@end
