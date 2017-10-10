//
//  OOHudTools.h
//  OOHttpRequest
//
//  Created by feng on 2017/10/10.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OOHudTools : NSObject


+ (void)showLoading;
+ (void)showLoadingInView:(UIView *)view;
+ (void)showLoadingWithtitle:(NSString *)title;
+ (void)showLoadingInView:(UIView *)view title:(NSString *)title;

+ (void)showErrorStatusWithtitle:(NSString *)title;
+ (void)showErrorStatusInView:(UIView *)view title:(NSString *)title;

+ (void)showSuccessStatusWithtitle:(NSString *)title;
+ (void)showSuccessStatusInView:(UIView *)view title:(NSString *)title;

+ (void)hideInView:(UIView *)view;
@end
