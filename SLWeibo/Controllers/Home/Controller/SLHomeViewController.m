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
@interface SLHomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    // 集成刷新
////    [self setupRefresh];
//    
//    
//    // 设置nav的item
//    [self.view addSubview:self.tableView];
//    [self loadData];

    
}

- (void)setupRefresh {
    
}
- (void)loadData {
    [SLWeiboApiTool getHotWeiboWithParam:@{@"param":@(1)} success:^(NSDictionary *result) {
        NSArray *tmpCardsArr = result[@"data"][@"cards"];
        self.cards = [SLStatusCard mj_objectArrayWithKeyValuesArray:tmpCardsArr];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cards.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SLStatusCell *cell = [SLStatusCell cellWithTableView:tableView];
    cell.statusCard = self.cards[indexPath.row];
    return cell;
}
#pragma mark - getter
- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [NSMutableArray array];
    }
    return _cards;
}
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}



@end
