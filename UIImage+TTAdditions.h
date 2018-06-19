//
//  UIImage+TTAdditions.h
//  TTLife
//
//  Created by tangshuanghui on 2017/11/23.
//  Copyright © 2017年 tangshuanghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TTAdditions)

/// 扫描图片中的二维码
- (NSString *)scanQRCode;

+ (NSString *)imageToString:(UIImage *)image;

+ (UIImage *)imageFromString:(NSString *)string;

+ (NSData *)compressImage:(UIImage *)image;

//+ (UIImage *)getImageFromDatasourceWithPhoto:(id) content;
@end
