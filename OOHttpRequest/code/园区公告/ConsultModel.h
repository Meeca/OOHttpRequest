//
//  ConsultModel.h
//  wuye
//
//  Created by feng on 2017/8/17.
//  Copyright © 2017年 冯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultModel : NSObject

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *thumb;
@property (strong, nonatomic) NSString *create_time;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *cid;

- (void)gardenNoticeInfowithPage:(NSInteger )page dataArray:(NSArray *)dataArray success:( void (^)(NSArray *modelArray))success;




@end
