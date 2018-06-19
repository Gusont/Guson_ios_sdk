//
//  AlertControllerShow.m
//  YaoDao
//
//  Created by daxucheng on 16/7/26.
//  Copyright © 2016年 ChengXu. All rights reserved.
//

#import "AlertControllerShow.h"
#define KAlertControllerLabelWeight 238.0

@implementation AlertControllerShow


+ (UIAlertController *)alertControllerShowWithTitle:(NSString *)title Message:(NSString *)message SurBtnTitle:(NSString *)surBtnTitle CancelBtnTitle:(NSString *)cancelBtnTitle SurBtnClick:(void(^)(void))surBtnClick CancelBtnClick:(void(^)(void))cancelBtnClick{
  
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
   
    if (cancelBtnTitle != nil) {
        
        [alert addAction:[UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            if (cancelBtnClick) {
                cancelBtnClick();
            }
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:surBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        if (surBtnClick) {
            surBtnClick();
        }
    }]];
    
    return alert;
}
+ (UIAlertController *)alertControllerShowSheetWithTitle:(NSString *)title Message:(NSString *)message actionTitles:(NSArray *)actionTitles actionCancel:(NSString *)cancelTitle actionDestructive:(NSString *)destructiveTitle alertActionBlock:(AlertActionBlock)actionBlock{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSInteger i = 0; i < actionTitles.count; i ++) {
        [alert addAction:[UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            actionBlock(UIAlertActionStyleDefault, i);
        }]];
    }
    if (cancelTitle != nil) {
        [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            actionBlock(UIAlertActionStyleCancel, 0);
        }]];
    }
    if (destructiveTitle != nil) {
        [alert addAction:[UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            if (actionBlock) {
                actionBlock(UIAlertActionStyleDestructive, 0);
            }
        }]];
    }

    return alert;
}
@end
