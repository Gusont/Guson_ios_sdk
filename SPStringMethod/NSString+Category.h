//
//  NSString+Category.h
//  SharedParking
//
//  Created by gui_huan on 2018/4/16.
//  Copyright © 2018年 gui_huan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

/*!
 @method
 @describe 计算获取文本的大小
 */
+ (CGSize)calculationTextNeedSizeWithText:(NSString *)text
                                     font:(CGFloat)font
                                    width:(CGFloat)width;


/**
 <#Description#>

 @param size 依附视图的大小
 @param text 文本
 @param font 文本大小
 @return 文本居于视图中心时的起始位置
 */
+ (CGPoint)calculationPointWithSize:(CGSize)size
                                text:(NSString *)text
                                font:(CGFloat)font;

/**
 调用一个get方法，也不算添加属性，仅方便书写
 金钱单位转换
 */
@property (nonatomic, copy)NSString *moneyConversion;
@end
