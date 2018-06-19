//
//  UIButton+ImageTitleSpacing.h
//  SystemPreferenceDemo
//
//  Created by moyekong on 12/28/15.
//  Copyright © 2015 wiwide. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop    = 0, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft   = 1, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom = 2, // image在下，label在上
    MKButtonEdgeInsetsStyleRight  = 3 // image在右，label在左
};

@interface UIButton (ImageTitleSpacing)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end



///在XIB中使用，增加一个继承类添加两个属性
IB_DESIGNABLE
@interface UIButtonImageTitleSpace: UIButton

@property (nonatomic, assign)IBInspectable CGFloat space;

@property (nonatomic, assign)IBInspectable MKButtonEdgeInsetsStyle btnEdgeInstsStyle;

@end
