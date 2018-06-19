//
//  FileOperationTool.h
//  SharedParking
//
//  Created by gui_huan on 2018/4/25.
//  Copyright © 2018年 tangshuanghui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ClearFileBlock)(float cacheSize);

@interface FileOperationTool : NSObject

//@property (nonatomic, copy)ClearFile clearFile;
-(float)readCacheSize;

- (void)clearFile:(ClearFileBlock)cacheSize;
@end
