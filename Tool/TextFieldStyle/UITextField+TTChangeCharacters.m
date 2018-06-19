//
//  UITextField+TTChangeCharacters.m
//  TTLife
//
//  Created by gui_huan on 2018/1/3.
//  Copyright © 2018年 tangshuanghui. All rights reserved.
//

#import "UITextField+TTChangeCharacters.h"

@implementation UITextField (TTChangeCharacters)



- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string ChangeCharactersStyle:(TTChangeCharactersStyle)changeCharactersStyle{
    
    if (changeCharactersStyle == ChangeCharactersMoney) {
        if (([string isEqualToString:@"."] || [string isEqualToString:@"0"]) && [self.text isEqualToString:@""]) {
            self.text = @"0.";
            return NO;
        }
        NSRange myRange = [self.text rangeOfString:@"."];
        if (myRange.length != 0) {
            //一个小数点
            if ([string isEqualToString:@"."]) {
                return NO;
            }
            //小数点后两位
            if ([self.text length]-myRange.location >= 3) {
                if ([string isEqualToString:@""]) {
                    
                    return YES;
                    
                }else {
                    return NO;
                }
                
            }else {
                return YES;
            }
            
        }else {
            if ([self.text length] < 10) {
                return YES;
            }else{
                if ([string isEqualToString:@""] || [string isEqualToString:@"."]) {
                    return YES;
                }else {
                    return NO;
                }
                
            }
            
        }
    }
    if (changeCharactersStyle == ChangeCharactersBank) {
        NSString *text = [self text];
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        // 限制长度
        if (newString.length >= 24) {
            return NO;
        }
        
        [self setText:newString];
        return NO;
    }
    return YES;
    
}
- (NSString *)getNormalBankNumber
{
    return [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}
@end
