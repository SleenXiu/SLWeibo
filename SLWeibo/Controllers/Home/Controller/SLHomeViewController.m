//
//  SLHomeViewController.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/3.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLHomeViewController.h"
#import "UIBarButtonItem+SL.h"
#import "SLTitleBtn.h"
#import "SLAccountTool.h"
#import "SLAccount.h"
#import "SLUser.h"
#import "SLStatus.h"
#import "SLStatusCell.h"
#import "SLStatusCard.h"
#import "SLStatusLayout.h"
@interface SLHomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *statusLayout;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.tableView];
    [self loadData];
    
}

- (void)setupRefresh {
    
}
- (void)loadData {
    
    [SLWeiboApiTool test_getHotTimeLineWithParam:@{} success:^(NSDictionary *result) {

        NSArray *tmpStatusArr = [SLStatus mj_objectArrayWithKeyValuesArray:result[@"statuses"]];
        NSLog(@"%@",result);
        NSLog(@"%zd",tmpStatusArr.count);
        NSMutableArray *tmpLayouts = [NSMutableArray array];
        for (SLStatus *status in tmpStatusArr) {
            SLStatusLayout *layout = [SLStatusLayout statusLayoutWithStatus:status];
            [tmpLayouts addObject:layout];
        }
        
        self.statusLayout = tmpLayouts;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}
#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusLayout.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SLStatusCell *cell = [SLStatusCell cellWithTableView:tableView];
    cell.statusLayout = self.statusLayout[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SLStatusLayout *layout = self.statusLayout[indexPath.row];
    return layout.cellHight;
}
#pragma mark - getter
- (NSMutableArray *)statusLayout {
    if (!_statusLayout) {
        _statusLayout = [NSMutableArray array];
    }
    return _statusLayout;
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        _tableView.backgroundColor = ksl(EDEEEF)
    }
    return _tableView;
}



@end
