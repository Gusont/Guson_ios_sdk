//
//  GetCurrentShowVC.m
//  SharedParking
//
//  Created by gui_huan on 2018/4/17.
//  Copyright © 2018年 gui_huan. All rights reserved.
//

#import "GetCurrentShowVC.h"

@implementation GetCurrentShowVC
#pragma mark - 取到当前控制器
+ (UIViewController *)getCurrentShowVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //可能有多个window
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    if (appRootVC.presentedViewController) {
        result = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    //    if ([nextResponder isKindOfClass:[UIViewController class]])
    //    {
    //        result = nextResponder;
    //    }
    //    else
    //    {
    //        result = window.rootViewController;
    //    }
    
    return result;
}
@end
