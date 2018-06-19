//
//  UITableView+Refresh.h
//  SharedParking
//
//  Created by gui_huan on 2018/5/22.
//  Copyright © 2018年 tangshuanghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef void(^TableListCount)(NSInteger listCount);

typedef void(^TableViewRefresh)(NSInteger pageNo, TableListCount listCount);

@interface UITableView (Refresh)

- (void)tableviewRefresh:(NSMutableArray *)dataArray TableViewRefresh:(TableViewRefresh)tableViewRefresh;

@property(nonatomic, copy)TableListCount listCount;

@end
