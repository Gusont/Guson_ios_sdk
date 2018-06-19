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
@interface UITableView (Refresh)<CYLTableViewPlaceHolderDelegate>

@end
@implementation UITableView (Refresh)


- (void)tableviewRefresh:(NSMutableArray *)dataArray PageNo:(CuttentPageNo)pageNum{
    
    __block NSInteger pageNo = 1;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [dataArray removeAllObjects];
        pageNo = 1;
        pageNum(pageNo);
    }];
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        pageNo++;
        pageNum(pageNo);
    }];
    [self.mj_header beginRefreshing];
    
}

- (void)tableviewRefreshpostListCount:(NSInteger)listCount{
    [self endRefreshing];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mj_footer.state = listCount < 10 ? MJRefreshStateNoMoreData : MJRefreshStateIdle;
        
    });
    [self cyl_reloadData];
}
- (void)endRefreshing{
    
//    if([self.mj_footer isRefreshing]) {
//        [self.mj_footer endRefreshing];
//    }
    if([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
}
#pragma mark - CYLTableViewPlaceHolderDelegate
- (UIView *)makePlaceHolderView
{
    TTTableViewPlaceView *placeView = [[TTTableViewPlaceView alloc]initWithFrame:self.frame];
    return placeView;
}
@end
