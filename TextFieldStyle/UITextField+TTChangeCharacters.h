//
//  UITextField+TTChangeCharacters.h
//  TTLife
//
//  Created by gui_huan on 2018/1/3.
//  Copyright © 2018年 tangshuanghui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,TTChangeCharactersStyle)
{
    ChangeCharactersMoney =0,//金钱类型==十位整数加两位小数
    ChangeCharactersBank = 1,//银行卡类型
};
@interface UITextField (TTChangeCharacters)


- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string ChangeCharactersStyle:(TTChangeCharactersStyle)changeCharactersStyle;

- (NSString *)getNormalBankNumber;
@end
