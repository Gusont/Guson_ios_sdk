//
//  JKCountDownButton.m
//  JKCountDownButton
//
//  Created by Jakey on 15/3/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "JKCountDownButton.h"
#import "GetCurrentShowVC.h"

#define KCountDownBtnSecond 60
@interface JKCountDownButton()
{
    NSInteger _second;
    NSUInteger _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    
    CountDownChanging _countDownChanging;
    CountDownFinished _countDownFinished;
}
//-(void)countDownChanging:(CountDownChanging)countDownChanging;
//-(void)countDownFinished:(CountDownFinished)countDownFinished;
//
//-(void)startCountDownWithSecond:(NSUInteger)second;
@end
@implementation JKCountDownButton


- (void)startCountDownWithZero{
    [self stopCountDown];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kSMSSendingFailure object:nil];
}
#pragma -mark touche action
-(void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler{
    _touchedCountDownButtonHandler = [touchedCountDownButtonHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touched:(JKCountDownButton*)sender{
    if (_touchedCountDownButtonHandler) {
        _touchedCountDownButtonHandler(sender,sender.tag);
    }
}

#pragma -mark count down method
-(void)startCountDownWithSecond:(NSUInteger)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startCountDownWithZero) name:kSMSSendingFailure object:nil];
}
-(void)timerStart:(NSTimer *)theTimer {
     double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
     _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;
        
    if (_second< 0.0)
    {
        [self stopCountDown];
    }
    else
    {
        if (_countDownChanging)
        {
            [self setTitle:_countDownChanging(self,_second) forState:UIControlStateNormal];
            [self setTitle:_countDownChanging(self,_second) forState:UIControlStateDisabled];

        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%zd秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];

        }
    }
}

- (void)stopCountDown{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_countDownFinished)
                {
                    [self setTitle:_countDownFinished(self,_totalSecond)forState:UIControlStateNormal];
                    [self setTitle:_countDownFinished(self,_totalSecond)forState:UIControlStateDisabled];

                }
                else
                {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];

                }
            }
        }
    }
}

#pragma -mark block
-(void)countDownChanging:(CountDownChanging)countDownChanging{
    _countDownChanging = [countDownChanging copy];
}
-(void)countDownFinished:(CountDownFinished)countDownFinished{
    _countDownFinished = [countDownFinished copy];
}

- (void)buttonClickWithStart{
    self.enabled = NO;
    [self startCountDownWithSecond:KCountDownBtnSecond];
    [self countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
        return title;
    }];
    [self countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return @"重新获取";
        
    }];
}

///当界面变化时提前释放
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (_timer != nil) {
        [_timer invalidate];
    }
}
- (void)dealloc{
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    CheckRunWhere;
}
@end
