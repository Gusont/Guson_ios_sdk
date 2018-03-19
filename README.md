# guson_ios_sdk

- (void)tableViewBeginRefresh{

self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
[self.modelArr removeAllObjects];
[self.mainTableView scrollsToTop];
self.pageNum = 1;
[self getUserIntegralLogs];
}];
self.mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
self.pageNum ++;
[self getUserIntegralLogs];
}];
[self.mainTableView.mj_header  beginRefreshing];
}
