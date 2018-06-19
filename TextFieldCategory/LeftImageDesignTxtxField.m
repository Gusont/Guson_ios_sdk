//
//  LeftImageDesignTxtxField.m
//  SharedParking
//
//  Created by gui_huan on 2018/4/10.
//  Copyright © 2018年 gui_huan. All rights reserved.
//

#import "LeftImageDesignTxtxField.h"

@implementation LeftImageDesignTxtxField

- (void)setLeftImage:(UIImage *)leftImage{
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat imageWidth = CGImageGetWidth(leftImage.CGImage) ;
    CGFloat imageHeight = CGImageGetHeight(leftImage.CGImage) ;
    CGFloat imageScale = imageWidth / imageHeight;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, (height - 4) *imageScale * 2, height - 4)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = leftImage;
    self.leftView = imageView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setLeftWithImage:(UIImage *)leftWithImage{
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat imageWidth = CGImageGetWidth(leftWithImage.CGImage) / [UIScreen mainScreen].scale + 10;
    CGFloat imageHeight = CGImageGetHeight(leftWithImage.CGImage) / [UIScreen mainScreen].scale ;
//    CGFloat imageScale = imageWidth / imageHeight;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, (height - imageHeight) / 2.0, imageWidth, imageHeight)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = leftWithImage;
    self.leftView = imageView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
