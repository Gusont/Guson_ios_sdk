//
//  MBProgressHUD+Addition.h
//  albume
//
//  Created by Qingliang Deng on 9/23/15.
//  Copyright © 2015 Clever Rock. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Addition)

+ (void)showLoadingMessage:(NSString *)message;
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideAfterDelay:(NSTimeInterval)delay withMessage:(NSString *)message;
+ (void)hideAfterDelay:(NSTimeInterval)delay withOnlyMessage:(NSString *)message;
@end
