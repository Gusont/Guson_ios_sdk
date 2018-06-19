//
//  AlertControllerShow.h
//  YaoDao
//
//  Created by daxucheng on 16/7/26.
//  Copyright © 2016年 ChengXu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AlertActionBlock)(UIAlertActionStyle style, NSInteger action);
@interface AlertControllerShow : NSObject

+ (UIAlertController *)alertControllerShowWithTitle:(NSString *)title Message:(NSString *)message SurBtnTitle:(NSString *)surBtnTitle CancelBtnTitle:(NSString *)cancelBtnTitle SurBtnClick:(void(^)(void))surBtnClick CancelBtnClick:(void(^)(void))cancelBtnClick;

+ (UIAlertController *)alertControllerShowSheetWithTitle:(NSString *)title Message:(NSString *)message actionTitles:(NSArray *)actionTitles actionCancel:(NSString *)cancelTitle actionDestructive:(NSString *)destructiveTitle alertActionBlock:(AlertActionBlock)actionBlock;
@end
