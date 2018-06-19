//
//  MenuView.m
//  YaoDao
//
//  Created by daxucheng on 16/5/23.
//  Copyright © 2016年 ChengXu. All rights reserved.
//

#import "MenuView.h"

//按钮宽度
#define KButtonWidth kSCREEN_WIDTH/4.0

@interface MenuView()
{
    menuViewDidSelectedAtIndexHandle _menuViewDidSelectedAtIndexHandle;
}
@property (nonatomic ,weak) UIScrollView *menuScrollView;
//标题
@property (nonatomic ,strong)NSArray *titleItems;
@end

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame withTitleItems:(NSArray*)titleItems
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _unSelectedTextColor = [UIColor grayColor];
        _selectedTextColor = [UIColor muneBtnSelColor];
        self.titleItems = titleItems;
    }
    
    return self;
}

- (UIScrollView *)menuScrollView{
    if (!_menuScrollView) {
        UIScrollView *scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        scr.showsHorizontalScrollIndicator = NO;
        scr.bounces = NO;
        [self addSubview:scr];
        _menuScrollView = scr;
    }
    return _menuScrollView;
}

- (void)setTitleItems:(NSArray *)titleItems{

    _titleItems = titleItems;
    self.menuScrollView.contentSize = CGSizeMake(KButtonWidth * titleItems.count, self.menuScrollView.frame.size.height);
    
    for (NSInteger i = 0; i < titleItems.count; i++) {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(KButtonWidth * i, 0, KButtonWidth , self.frame.size.height);
        [button setTitle:_titleItems[i] forState:UIControlStateNormal];
        
        [button setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        
        [button setTitleColor:_unSelectedTextColor forState:UIControlStateNormal];
        button.tag = i + 1;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.menuScrollView addSubview:button];
        
    }
}

- (void)setMenuViewDidSelectedAtIndex:(menuViewDidSelectedAtIndexHandle)handle{
    
    _menuViewDidSelectedAtIndexHandle = handle;

}

#pragma mark - 菜单按钮点击
- (void)buttonClick:(UIButton *)button
{
    NSInteger index = button.tag - 1;
    if (_selectedIndex != index) {
        //1.按钮的中心点
        CGFloat buttonCenterX = button.center.x;
        
        //2.处理按钮选中
        [self menuButtonClickHandle:button];
        
        //3.滚动视图偏移量的处理
        [self menuScrollViewContentOffsetHandleWithCenterX:buttonCenterX];
        
        //4.记录当前的index
        _selectedIndex = index;
        
        //4.回调
        if (_menuViewDidSelectedAtIndexHandle)
        {
            _menuViewDidSelectedAtIndexHandle(index);
        }
        UIView *view = [self.menuScrollView viewWithTag:1122];
        
        CGFloat view_X = CGRectGetMinX(view.frame);
        CGFloat button_X = CGRectGetMinX(button.frame);
        CGFloat absX  = fabs(button_X - view_X);
        CGFloat timeX = absX /CGRectGetWidth(button.frame) *0.3;
        //    NSLog(@"%f",timeX);
        [UIView animateWithDuration:timeX animations:^{
            view.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame)-12, CGRectGetWidth(button.frame), 3);
        }];

    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    /** 防止被连续点中 **/
    _selectedIndex = selectedIndex;
    //1.清除所有按钮的状态
    [self clearAllButtonSelectedStatus];
    
    //2.修改当前选中按钮的selected
    UIButton *btn = (UIButton *)[self.menuScrollView viewWithTag:selectedIndex + 1];
    btn.selected = YES;
    
    //3.修改偏移
    [self menuScrollViewContentOffsetHandleWithCenterX:btn.center.x];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn.frame)-3, CGRectGetWidth(btn.frame), 3)];
    view.backgroundColor = [UIColor muneBtnSelColor];
    view.tag = 1122;
    [self.menuScrollView addSubview:view];
}

#pragma mark - 清除所有按钮的状态
- (void)clearAllButtonSelectedStatus
{
    for (int i = 0; i < _titleItems.count; i++)
    {
        UIButton *btn = (UIButton *)[self.menuScrollView viewWithTag:i+1];
        btn.selected = NO;
    }
}

#pragma mark - 处理按钮选中
- (void)menuButtonClickHandle:(UIButton *)button
{
    //清除所有按钮的状态
    [self clearAllButtonSelectedStatus];
    
    button.selected = YES;
}

#pragma mark - 滚动视图偏移量的处理
- (void)menuScrollViewContentOffsetHandleWithCenterX:(CGFloat)centerX
{
    //滚动视图X的偏移量 = 按钮的中心点x - 当前屏幕宽度的一半
    CGFloat xOffset = centerX - self.menuScrollView.frame.size.width/2;
    
    //左边偏移限制:如果按钮的中心点小于屏幕的一半。不能偏移。
    if (centerX < self.menuScrollView.frame.size.width/2)
    {
        xOffset = 0;
    }
    else if (centerX > self.menuScrollView.contentSize.width - self.menuScrollView.frame.size.width/2)
    {
        //最大偏移量
        xOffset = self.menuScrollView.contentSize.width - self.menuScrollView.frame.size.width;
    }
    
    
    //修改偏移量
    [self.menuScrollView setContentOffset:CGPointMake(xOffset, 0) animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
