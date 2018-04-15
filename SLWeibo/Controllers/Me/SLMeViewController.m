//
//  SLMeViewController.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/3.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLMeViewController.h"
#import "SLSetController.h"
#import "SLMeSectionCell.h"
@interface SLMeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) SLBaseTableView *tableView;
@property (nonatomic, strong) NSArray *cellConfig;
@end

@implementation SLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setBtnClick:)];
    
    [self.view addSubview:self.tableView];
}

- (void)setBtnClick:(UIBarButtonItem *)item
{
    SLSetController *set = [[SLSetController alloc] init];
    set.title = @"设置";
    [self.navigationController pushViewController:set animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.cellConfig.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SLMeSectionCell *cell = [SLMeSectionCell meSectionCellWithTableView:tableView];
    return cell;
}

#pragma mark - Table view data source

- (SLBaseTableView *)tableView {
    if (!_tableView) {
        SLBaseTableView *view = [SLBaseTableView createBaseTableView];
        view.frame = CGRectMake(0, kSLNavBarHeight, kSLScreenWidth, kSLScreenHeight-kSLNavBarHeight-kSLTabBarHeight);
        view.delegate = self;
        view.dataSource = self;
        _tableView = view;
    }
    return _tableView;
}

@end
