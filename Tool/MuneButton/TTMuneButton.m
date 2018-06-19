//
//  TTMuneButton.m
//  TTLife
//
//  Created by gui_huan on 2017/11/23.
//  Copyright © 2017年 tangshuanghui. All rights reserved.
//

#import "TTMuneButton.h"

@interface TTMuneButton()

@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIButton *exChengBtn;
@property (nonatomic, assign)NSInteger titlesCount;
@end
@implementation TTMuneButton

- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        [self confignMuneButtonWithTitles:titles];
    }
    return self;
}
- (void)confignMuneButtonWithTitles:(NSArray *)titles{
    
    self.titlesCount = titles.count;
    float btnWidth = CGRectGetWidth(self.frame) / titles.count;
  
    for (NSInteger i = 0; i < titles.count ; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.frame = CGRectMake( btnWidth * i, 0, btnWidth, CGRectGetHeight(self.frame));
        [btn addTarget:self action:@selector(btnClick:) forControlEvents: UIControlEventTouchUpInside];
        btn.tag = 1133 + i;
        [btn setTitleColor:[UIColor muneBtnNorColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor muneBtnSelColor] forState:UIControlStateSelected];
        [self addSubview:btn];
    }
    self.exChengBtn = (UIButton *)[self viewWithTag:1133];
    self.exChengBtn.selected = YES;
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor muneBtnSelColor];
    _lineView.frame = CGRectMake(CGRectGetMinX(_exChengBtn.frame), CGRectGetMaxY(_exChengBtn.frame) - 3, CGRectGetWidth(_exChengBtn.frame), 3);
    [self addSubview:_lineView];
}
- (void)btnClick:(UIButton *)btn{
    if (self.exChengBtn == btn) {
        return;
    }
    btn.selected = YES;
    self.exChengBtn.selected = NO;
    [self setLineViewFrameWith:btn];
    self.exChengBtn = btn;
    if (self.menuBtnClick) {
        self.menuBtnClick(btn.tag - 1133);
    }
    
}
- (void)setLineViewFrameWith:(UIButton *)btn{

    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn.frame) - 3, CGRectGetWidth(btn.frame), 3);
    }];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    /** 防止被连续点中 **/
    _selectedIndex = selectedIndex;
    //1.清除所有按钮的状态
    [self clearAllButtonSelectedStatus];
    
    //2.修改当前选中按钮的selected
    UIButton *btn = (UIButton *)[self viewWithTag:selectedIndex + 1133];
    [self btnClick:btn];
}
#pragma mark - 清除所有按钮的状态
- (void)clearAllButtonSelectedStatus
{
    for (int i = 0; i < self.titlesCount; i++)
    {
        UIButton *btn = (UIButton *)[self viewWithTag:i+1133];
        btn.selected = NO;
    }
}
@end
