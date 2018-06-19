//
//  UITableView+Refresh.m
//  SharedParking
//
//  Created by gui_huan on 2018/5/22.
//  Copyright © 2018年 tangshuanghui. All rights reserved.
//

#import "UITableView+Refresh.h"
#import "UITableView+CYLTableViewPlaceHolder.h"
#import "CYLTableViewPlaceHolderDelegate.h"
#import "TTTableViewPlaceView.h"
#import <objc/runtime.h>
@interface UITableView (MJRefresh)<CYLTableViewPlaceHolderDelegate>


@end
@implementation UITableView (Refresh)

static char *count = "listCount";


- (void)tableviewRefresh:(NSMutableArray *)dataArray TableViewRefresh:(TableViewRefresh)tableViewRefresh{
    WEAKSELF;
    __block NSInteger pageNo = 1;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [dataArray removeAllObjects];
        pageNo = 1;
        tableViewRefresh(pageNo, wkSelf.listCount);
    }];
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        pageNo++;
        tableViewRefresh(pageNo, wkSelf.listCount);
    }];
    [self.mj_header beginRefreshing];
    self.listCount = ^(NSInteger listCount) {
        
        [wkSelf tableviewRefreshpostListCount:listCount];
        
    };
    
}
- (void)tableviewRefreshpostListCount:(NSInteger)listCount{
    [self endRefreshing];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mj_footer.state = listCount < 10 ? MJRefreshStateNoMoreData : MJRefreshStateIdle;
        
    });
    [self cyl_reloadData];
}
- (void)endRefreshing{
    if([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
}

- (TableListCount)listCount{
    return objc_getAssociatedObject(self, count);

}
- (void)setListCount:(TableListCount)listCount{
    objc_setAssociatedObject(self, count, listCount, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark - CYLTableViewPlaceHolderDelegate
- (UIView *)makePlaceHolderView
{
    TTTableViewPlaceView *placeView = [[TTTableViewPlaceView alloc]initWithFrame:self.frame];
    return placeView;
}

//- (void)dealloc{
//    CheckRunWhere;
//}
@end
