//
//  JSONModel+KeyForValueDict.h
//  SharedParking
//
//  Created by gui_huan on 2018/4/25.
//  Copyright © 2018年 tangshuanghui. All rights reserved.
//

#import "JSONModel.h"

@interface JSONModel (KeyForValueDict)

- (NSDictionary *)properties_aps;

- (instancetype)GetClassValueWithSonClass:(id)sonClass;

@end
