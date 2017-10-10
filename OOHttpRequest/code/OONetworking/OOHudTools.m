
//
//  OOHudTools.m
//  OOHttpRequest
//
//  Created by feng on 2017/10/10.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "OOHudTools.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@implementation OOHudTools

+(UIView *)window{
    AppDelegate * appdelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView * view = appdelegate.window.rootViewController.view;
    return view;
}


+ (void)showLoading{
    
    [self showLoadingInView:[self window]];;
    
}

+ (void)showLoadingInView:(UIView *)view{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)showLoadingWithtitle:(NSString *)title{
    
    [self showLoadingInView:[self window] title:title];
}

+ (void)showLoadingInView:(UIView *)view title:(NSString *)title{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = title;
    
}
+ (void)showErrorStatusWithtitle:(NSString *)title{
    
     [self showErrorStatusInView:[self window] title:title];
}


+ (void)showErrorStatusInView:(UIView *)view title:(NSString *)title{
    
    [self hideInView:view];

    if (title.length > 4) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = title;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //        [MBProgressHUD hideAllHUDsForView:view animated:YES];
            [hud hideAnimated:YES afterDelay:0.5];
            
        });
    }
    
  
}


+ (void)showSuccessStatusWithtitle:(NSString *)title{
     [self showSuccessStatusInView:[self window] title:title];
}


+ (void)showSuccessStatusInView:(UIView *)view title:(NSString *)title{
    
    [self hideInView:view];
    
    if (title.length > 4) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = title;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES afterDelay:0.5];
        });
    }
}
+ (void)hide{
    
     [MBProgressHUD hideHUDForView:[self window] animated:YES];

}

+ (void)hideInView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}


@end
