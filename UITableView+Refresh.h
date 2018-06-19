//
//  UITableView+Refresh.h
//  SharedParking
//
//  Created by gui_huan on 2018/5/22.
//  Copyright © 2018年 tangshuanghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef void(^TableViewRefreshListCount)(NSInteger listCount);

typedef void(^CuttentPageNo)(NSInteger pageNo);

@interface UITableView (Refresh)

- (void)tableviewRefresh:(NSMutableArray *)dataArray PageNo:(CuttentPageNo)pageNum;


- (void)tableviewRefreshpostListCount:(NSInteger)listCount;

- (void)endRefreshing;
@end
