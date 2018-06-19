//
//  UIView+SPAddShadow.m
//  SharedParking
//
//  Created by gui_huan on 2018/6/15.
//  Copyright © 2018年 tangshuanghui. All rights reserved.
//

#import "UIView+SPAddShadow.h"

@implementation UIView (SPAddShadow)



- (void)addShadowWithBezierPath{
    CGFloat shadowWeigth = 1;
    CGFloat shadowWeight1 = 0;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(shadowWeight1, 2)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) + shadowWeigth, 2)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) + shadowWeigth, CGRectGetHeight(self.frame) + 2 * shadowWeigth)];
    [path addLineToPoint:CGPointMake(shadowWeight1, CGRectGetHeight(self.frame) + 2 * shadowWeigth)];
    [path closePath];
    
    self.layer.shadowColor = [UIColor labelTextColor].CGColor;
    self.layer.shadowOpacity = 0.4f;
    self.layer.shadowRadius = 4;
    self.layer.shadowPath = path.CGPath;
}
@end
