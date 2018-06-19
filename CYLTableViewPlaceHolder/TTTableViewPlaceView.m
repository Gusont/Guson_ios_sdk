//
//  TTTableViewPlaceView.m
//  TTLife
//
//  Created by gui_huan on 2017/12/7.
//  Copyright © 2017年 tangshuanghui. All rights reserved.
//

#import "TTTableViewPlaceView.h"
@interface TTTableViewPlaceView()

@property(nonatomic, strong)UILabel *titleLabel;
@end
@implementation TTTableViewPlaceView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self confignUI];
    }
    return self;
}
- (void)confignUI{
    [self addSubview:self.placeImageView];
    [self addSubview:self.titleLabel];
    [self.placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@60);
        make.height.equalTo(@(60*0.88));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.placeImageView.mas_bottom).offset(16);
    }];
}

- (UIImageView *)placeImageView{
    if (!_placeImageView) {
        _placeImageView = [[UIImageView alloc]init];
        _placeImageView.image = ImageName(@"icon_place_tableview");
    }
    return _placeImageView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.text = @"没有数据";
        _titleLabel.textColor = [UIColor darkGrayColor];
    }
    return _titleLabel;
}
@end
