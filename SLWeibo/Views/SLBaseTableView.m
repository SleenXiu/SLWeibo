//
//  SLBaseTableView.m
//  SLWeibo
//
//  Created by QMP on 2018/4/15.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import "SLBaseTableView.h"

@implementation SLBaseTableView
+ (SLBaseTableView *)createBaseTableView {
    SLBaseTableView *tableView = [[SLBaseTableView alloc] init];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

@end
