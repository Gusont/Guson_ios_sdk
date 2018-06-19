//
//  TTMuneButton.h
//  TTLife
//
//  Created by gui_huan on 2017/11/23.
//  Copyright © 2017年 tangshuanghui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^menuButtonClick)(NSInteger index);

@interface TTMuneButton : UIView

- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titles;
@property (nonatomic ,copy) menuButtonClick menuBtnClick;

//选中的按钮下标======加了点击操作，使用时需注意
@property (nonatomic)NSInteger selectedIndex;
@end
