//
//  MBProgressHUD+Addition.m
//  albume
//
//  Created by Qingliang Deng on 9/23/15.
//  Copyright © 2015 Clever Rock. All rights reserved.
//

#import "MBProgressHUD+Addition.h"

@implementation MBProgressHUD (Addition)

+ (void)showLoadingMessage:(NSString *)message
{
    [self showLoadingMessage:message toView:nil];
}

+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication] keyWindow];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud hideAnimated:NO];
    return hud;
}

+ (void)hideAfterDelay:(NSTimeInterval)delay withMessage:(NSString *)message
{
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    [self hideHUDForView:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = message;
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud hideAnimated:YES afterDelay:delay];
}

+ (void)hideAfterDelay:(NSTimeInterval)delay withOnlyMessage:(NSString *)message
{
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    [self hideHUDForView:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = message;
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:delay];
}


+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication] keyWindow];
    }
    [self hideHUDForView:view animated:YES];
}

@end
