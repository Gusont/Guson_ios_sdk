//
//  CALayer+LayerColor.m
//  SharedParking
//
//  Created by gui_huan on 2018/4/10.
//  Copyright © 2018年 gui_huan. All rights reserved.
//

#import "CALayer+LayerColor.h"
#import <objc/runtime.h>
@implementation CALayer (LayerColor)
static char *borderColor = "borderColor";

- (UIColor *)borderColorFromUIColor{

    return objc_getAssociatedObject(self, borderColor);
}

- (void)setBorderColorFromUIColor:(UIColor *)borderColorFromUIColor{
    self.borderColor = borderColorFromUIColor.CGColor;
    
    objc_setAssociatedObject(self, borderColor, borderColorFromUIColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
