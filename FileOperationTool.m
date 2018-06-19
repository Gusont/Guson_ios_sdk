//
//  FileOperationTool.m
//  SharedParking
//
//  Created by gui_huan on 2018/4/25.
//  Copyright © 2018年 tangshuanghui. All rights reserved.
//

#import "FileOperationTool.h"

@implementation FileOperationTool

-(float)readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [ self folderSizeAtPath :cachePath];
}
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        //不可修改文件Snapshots
        if (![fileAbsolutePath hasSuffix:@"Snapshots"]) {
            folderSize += [self fileSizeAtPath :fileAbsolutePath];
        }
    }
    
    return folderSize/( 1024.0 * 1024.0);
}
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}
- (void)clearFile:(ClearFileBlock)cacheSize{
    
    dispatch_queue_t queut = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queut, ^{
        NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
        NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
        
        //        NSLog ( @"cachpath = %@  == %@" , cachePath,files);
        for ( NSString * p in files) {
            NSError * error = nil ;
            //获取文件全路径
            NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
            
            if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
                [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
            }
        }
        
        //读取缓存大小
        float cacheSizeFloat = [self readCacheSize] *1024;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cacheSize) {
                cacheSize(cacheSizeFloat);
            }
        });
    });
}

@end
