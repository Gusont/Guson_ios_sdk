//
//  HHYAlertView.m
//  HHYLife-Shop
//
//  Created by tangshuanghui on 2017/7/18.
//  Copyright © 2017年 tangshuanghui. All rights reserved.
//

#import "HHYAlertView.h"
#import "UIAlertController+Block.h"

@interface HHYAlertView ()

@end

@implementation HHYAlertView

+ (void)showTitle:(NSString *)title
  cancelButtonTitle:(NSString *)cancelTitle
            message:(NSString *)message
{
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if (presentingViewController.presentingViewController != nil) {
        presentingViewController = presentingViewController.presentedViewController;
    }
    
    if (title == nil) {
        title = @"";
    }
    [UIAlertController showAlertInViewController:presentingViewController
                                       withTitle:title
                                         message:message
                               cancelButtonTitle:cancelTitle
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex)
     {
         
     }];
}

+ (void)showMessage:(NSString *)message
              title:(NSString *)title
  cancelButtonTitle:(NSString *)cancelTitle
  otherButtonTitles:(NSArray *)titlesArray
        actionBlock:(void (^)(NSUInteger))block
{
    if (title == nil) {
        title = @"";
    }
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if (presentingViewController.presentingViewController != nil) {
        presentingViewController = presentingViewController.presentedViewController;
    }
    
    [UIAlertController showAlertInViewController:presentingViewController
                                       withTitle:title
                                         message:message
                               cancelButtonTitle:cancelTitle
                          destructiveButtonTitle:nil
                               otherButtonTitles:titlesArray
                                        tapBlock:^(UIAlertController * controller, UIAlertAction * action, NSInteger buttonIndex)
     {
         block(buttonIndex);
     }];
}

+ (void)showActionSheet:(NSString *)title
           buttonTitles:(NSArray *)titlesArray
            actionBlock:(void (^)(NSUInteger buttonIndex))block
{
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if (presentingViewController.presentingViewController != nil) {
        presentingViewController = presentingViewController.presentedViewController;
    }
    
    [UIAlertController showActionSheetInViewController:presentingViewController
                                             withTitle:title
                                               message:nil
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:titlesArray
                                              tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex)
     {
         block(buttonIndex);
     }];
}

+ (void)showDestructiveActionSheet:(NSString *)title
            destructiveButtonTitle:(NSString *)destructiveButtonTitle
                       actionBlock:(void (^)(NSUInteger buttonIndex))block
{
    UIViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    if (presentingViewController.presentingViewController != nil) {
        presentingViewController = presentingViewController.presentedViewController;
    }
    
    [UIAlertController showActionSheetInViewController:presentingViewController
                                             withTitle:nil
                                               message:title
                                     cancelButtonTitle:(@"取消")
                                destructiveButtonTitle:destructiveButtonTitle
                                     otherButtonTitles:nil
                                              tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex)
     {
         block(buttonIndex);
     }];
}

+ (void)showDestructiveActionSheetWithPresenting:(UIViewController *)presentingController
                                           title:(NSString *)title
                          destructiveButtonTitle:(NSString *)destructiveButtonTitle
                                     actionBlock:(void (^)(NSUInteger buttonIndex))block
{
    [UIAlertController showActionSheetInViewController:presentingController
                                             withTitle:nil
                                               message:title
                                     cancelButtonTitle:(@"取消")
                                destructiveButtonTitle:destructiveButtonTitle
                                     otherButtonTitles:nil
                                              tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex)
     {
         block(buttonIndex);
     }];
}

@end
