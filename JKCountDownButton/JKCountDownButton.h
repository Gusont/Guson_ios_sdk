//
//  JKCountDownButton.h
//  JKCountDownButton
//
//  Created by Jakey on 15/3/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKCountDownButton;
typedef NSString* (^CountDownChanging)(JKCountDownButton *countDownButton,NSUInteger second);
typedef NSString* (^CountDownFinished)(JKCountDownButton *countDownButton,NSUInteger second);

typedef void (^TouchedCountDownButtonHandler)(JKCountDownButton *countDownButton,NSInteger tag);

@interface JKCountDownButton : UIButton
{
   
    TouchedCountDownButtonHandler _touchedCountDownButtonHandler;
}

//点击事件回调
-(void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;


-(void)stopCountDown;

//点击后重置状态
- (void)buttonClickWithStart;


/*!
 @method
 @describe 使用一个通用的方法
 */
//- (void)countDownWithSecond:(NSUInteger)second changingTitle:(NSString *)changingTitle finishedTitle:(NSString *)finishenTitle handler:(TouchedCountDownButtonHandler)handler;

@end
