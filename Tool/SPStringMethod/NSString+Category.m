//
//  NSString+Category.m
//  SharedParking
//
//  Created by gui_huan on 2018/4/16.
//  Copyright © 2018年 gui_huan. All rights reserved.
//

#import "NSString+Category.h"
#import <objc/runtime.h>
@implementation NSString (Category)
static char *MoneyConversion = "moneyConversion";
#pragma mark - 根据宽度计算文本的高度
+ (CGSize)calculationTextNeedSizeWithText:(NSString *)text
                                     font:(CGFloat)font
                                    width:(CGFloat)width{
    
    NSDictionary *fontDic = @{NSFontAttributeName :[UIFont systemFontOfSize:font],
                              };

    CGRect fontRect =  [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDic context:nil];
    return fontRect.size;
}
+ (CGPoint)calculationPointWithSize:(CGSize)size
                                text:(NSString *)text
                                font:(CGFloat)font{
    NSDictionary *fontDic = @{NSFontAttributeName :[UIFont systemFontOfSize:font],
                              };
    
    CGSize textSize = [text sizeWithAttributes:fontDic];
    CGFloat pointX = (size.width - textSize.width) /2.;
    CGFloat pointY = (size.height - textSize.height) / 2.;
    return CGPointMake(pointX, pointY);

}


- (NSString *)moneyConversion{
    
    NSString *str = [NSString stringWithFormat:@"%.2f", ([self integerValue] /100.0)];
    return str;
}
- (void)setMoneyConversion:(NSString *)moneyConversion{
    ///以分为单位
    objc_setAssociatedObject(self, MoneyConversion, moneyConversion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
