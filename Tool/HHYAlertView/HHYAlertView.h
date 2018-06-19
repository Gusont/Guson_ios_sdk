//
//  HHYAlertView.h
//  HHYLife-Shop
//
//  Created by tangshuanghui on 2017/7/18.
//  Copyright © 2017年 tangshuanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHYAlertView : UIAlertController

+ (void)showTitle:(NSString *)title
  cancelButtonTitle:(NSString *)cancelTitle
            message:(NSString *)message;

+ (void)showMessage:(NSString *)message
              title:(NSString *)title
  cancelButtonTitle:(NSString *)cancelTitle
  otherButtonTitles:(NSArray *)titlesArray
        actionBlock:(void (^)(NSUInteger buttonIndex))block;

+ (void)showActionSheet:(NSString *)title
           buttonTitles:(NSArray *)titlesArray
            actionBlock:(void (^)(NSUInteger buttonIndex))block;

+ (void)showDestructiveActionSheet:(NSString *)title
            destructiveButtonTitle:(NSString *)destructiveButtonTitle
                       actionBlock:(void (^)(NSUInteger buttonIndex))block;

+ (void)showDestructiveActionSheetWithPresenting:(UIViewController *)presentingController
                                           title:(NSString *)title
                          destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                     actionBlock:(void (^)(NSUInteger buttonIndex))block;

@end
