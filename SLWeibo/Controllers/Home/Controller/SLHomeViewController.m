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
@property (nonatomic, strong) UIButton *searchButton;
@end

@implementation SLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.tableView];
    [self loadData];
    
    [self.tableView addSubview:self.searchButton];
    
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
        CGRect rect = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kSLBackGroundColor;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _tableView.contentInset = UIEdgeInsetsMake(43, 0, 0, 0);
    }
    return _tableView;
}

- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [[UIButton alloc] init];
        _searchButton.frame = CGRectMake(8, (43-27)*0.5-43, kSLScreenWidth-16, 27);
        _searchButton.titleLabel.font = kSLFont(13);
        _searchButton.layer.cornerRadius = 4.0;
        _searchButton.clipsToBounds = YES;
        [_searchButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_searchButton setBackgroundImage:[UIImage imageWithColor:kSLColorHex(@"F9F9F9")] forState:UIControlStateHighlighted];
        [_searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [_searchButton setTitle:@"大家正在搜：邓超怼怼怼" forState:UIControlStateNormal];
        [_searchButton setTitleColor:kSLColorHex(@"B8B8B8") forState:UIControlStateNormal];
        _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 8, 0, -8);
        _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 16, 0, -16);
    }
    return _searchButton;
}

@end
