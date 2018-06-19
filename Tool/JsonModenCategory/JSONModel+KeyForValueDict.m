//
//  JSONModel+KeyForValueDict.m
//  SharedParking
//
//  Created by gui_huan on 2018/4/25.
//  Copyright © 2018年 tangshuanghui. All rights reserved.
//

#import "JSONModel+KeyForValueDict.h"
#import <objc/runtime.h>

@implementation JSONModel (KeyForValueDict)

//Model 到字典
- (NSDictionary *)properties_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:propertyName];
        propertyValue = propertyValue ? propertyValue : @"";
        //        if (propertyValue)
        [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

//子类--->只获取父类的值
- (instancetype)GetClassValueWithSonClass:(id)sonClass
{
//    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [sonClass valueForKey:propertyName];
        propertyValue = propertyValue ? propertyValue : @"";
        //        if (propertyValue)
//        [props setObject:propertyValue forKey:propertyName];
        [self setValue:propertyValue forKey:propertyName];
    }
    free(properties);
    return self;
}


@end
