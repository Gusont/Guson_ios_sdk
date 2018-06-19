//
//  UIImage+TTAdditions.m
//  TTLife
//
//  Created by tangshuanghui on 2017/11/23.
//  Copyright © 2017年 tangshuanghui. All rights reserved.
//

#import "UIImage+TTAdditions.h"
//#import "CRAssetEntity.h"
//#import "CRAlbumePhotoDataWorker.h"
@implementation UIImage (TTAdditions)

- (NSString *)scanQRCode {
    if (!self) {
        return @"";
    }
    if (![self isKindOfClass:[UIImage class]]) {
        return @"";
    }
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:[CIContext contextWithOptions:nil] options:@{CIDetectorAccuracy:CIDetectorAccuracyLow}];
    NSData *data = [self compressImage:self];
    TT_LOG(@"%ld", data.length / 1024);
    NSArray *features = [detector featuresInImage:[CIImage imageWithData:data]];
    if (features.count == 0) {
        return @"";
    }
    for (CIFeature *feat in features) {
        if ([feat isKindOfClass:[CIQRCodeFeature class]]) {
            return ((CIQRCodeFeature *)feat).messageString;
        }
    }
    return @"";
}

// 压缩图片
- (NSData *)compressImage:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1);
    CGFloat scale = 0.9;
    while (data.length / 1024 > 500) {
        data = UIImageJPEGRepresentation(image, scale);
        scale -= 0.1;
    }
    return data;
}
// 图片转字符串
+ (NSString *)imageToString:(UIImage *)image
{
    // UIImage --> NSData
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    // NSData --> NSString
    NSString *imageDataString = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return imageDataString;
}
// 字符串转图片
+ (UIImage *)imageFromString:(NSString *)string
{
    // NSString --> NSData
    NSData *data=[[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    // NSData --> UIImage
    UIImage *image = [UIImage imageWithData:data];
    return image;
}
+ (NSData *)compressImage:(UIImage *)image {
    CGFloat scale = image.size.height / image.size.width;
    CGSize size = CGSizeMake(240, 240*scale);
//    DYJLog(@"imagesize:%@ oldimage:%ld", NSStringFromCGSize(size), (unsigned long)UIImagePNGRepresentation(image).length/1024);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imagedata = UIImagePNGRepresentation(smallImage);
//    DYJLog(@"newImage:%ld", (unsigned long)imagedata.length/1024);
    CGFloat compereScale = 0.9;
    // 将图片压至小于200kb
    while (200*1024.0 < imagedata.length) {
        imagedata = UIImageJPEGRepresentation(smallImage, compereScale);
        compereScale -= 0.1;
//        DYJLog(@"scaleimage:%ld", (unsigned long)imagedata.length/1024);
    }
    return imagedata;
}

// 从addview的数据源中获取image   数据源可能是image也可能是CRAssetEntity类
//+ (UIImage *)getImageFromDatasourceWithPhoto:(id) content{
//    //    id content = self.addView.datasource[index];
//    if ([content isKindOfClass:[UIImage class]]) {
//        return (UIImage *)content;
//    }else if ([content isKindOfClass:[CRAssetEntity class]]) {
//        PHAsset *asset = ((CRAssetEntity *)content).asset;
//        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//        // 同步获得照片,只会返回一张
//        options.synchronous = YES;
//        // 原图
//        CGSize size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
//        __block UIImage *image;
//        [[PHImageManager defaultManager] requestImageForAsset:asset
//                                                   targetSize:size
//                                                  contentMode:PHImageContentModeAspectFill
//                                                      options:options
//                                                resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//                                                    image = result;
//                                                }];
//        return image;
//    }else {
//        return nil;
//    }
//}
@end
