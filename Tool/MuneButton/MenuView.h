//
//  MenuView.h
//  YaoDao
//
//  Created by daxucheng on 16/5/23.
//  Copyright © 2016年 ChengXu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^menuViewDidSelectedAtIndexHandle)(NSInteger index);

@interface MenuView : UIView



//选中的字体颜色
@property (nonatomic ,strong)UIColor *selectedTextColor;

//字体颜色
@property (nonatomic ,strong)UIColor *unSelectedTextColor;

//选中的按钮下标
@property (nonatomic)NSInteger selectedIndex;

- (instancetype)initWithFrame:(CGRect)frame withTitleItems:(NSArray*)titleItems;

- (void)setMenuViewDidSelectedAtIndex:(menuViewDidSelectedAtIndexHandle)handle;

@end
