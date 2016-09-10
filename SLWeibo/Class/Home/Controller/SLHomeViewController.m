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
#import "AFNetworking.h"
#import "SLAccount.h"
#import "UIImageView+WebCache.h"
#import "SLUser.h"
#import "SLStatus.h"
#import "MJExtension.h"
#import "SLStatusFrame.h"
#import "SLStatusCell.h"
#import "UIImage+SL.h"
#import "MJRefresh.h"
@interface SLHomeViewController ()
@property (nonatomic, strong) NSMutableArray *statusFrames;

@property (nonatomic, weak) MJRefreshFooter *footer;
@property (nonatomic, weak) MJRefreshHeader *header;
@end

@implementation SLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 集成刷新
    [self setupRefresh];
    
    
    // 设置nav的item
    [self setupNavItem];
    

}

- (void)setupRefresh
{
    MJRefreshNormalHeader *head = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshControlStateChange:)];
    self.tableView.mj_header = head;
    self.header = head;
    
    // 自动进入刷新状态(不会触发监听方法)
    //[head beginRefreshing];
    // 直接加载数据
    [self refreshControlStateChange:head];
    
    MJRefreshBackNormalFooter *foot = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOldData:)];
    self.tableView.mj_footer = foot;
    self.footer = foot;
}
/**
 *  加载上拉刷新更久的数据
 */
- (void)loadOldData:(MJRefreshBackNormalFooter *)foot
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SLAccountTool account].access_token;
    params[@"count"] = @5;
    if (self.statusFrames.count) {
        SLStatusFrame *statusFrame = [self.statusFrames lastObject];
        // 加载ID <= max_id的微博
        long long maxId = [statusFrame.status.idstr longLongValue] - 1;
        params[@"max_id"] = @(maxId);
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 将字典数组转为模型数组(里面放的就是IWStatus模型)
        NSArray *statusArray = [SLStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (SLStatus *status in statusArray) {
            SLStatusFrame *statusFrame = [[SLStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 添加新数据到旧数据的后面
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    }];

}

/**
 *  监听刷新控件的状态改变(手动进入刷新状态才会调用这个方法)
 */
- (void)refreshControlStateChange:(MJRefreshNormalHeader *)refreshControl
{
    // 刷新数据(向新浪获取更新的微博数据)
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SLAccountTool account].access_token;
    params[@"count"] = @5;
    if (self.statusFrames.count) {
        SLStatusFrame *statusFrame = self.statusFrames[0];
        // 加载ID比since_id大的微博
        params[@"since_id"] = statusFrame.status.idstr;
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        // 将字典数组转为模型数组(里面放的就是IWStatus模型)
        NSArray *statusArray = [SLStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (SLStatus *status in statusArray) {
            SLStatusFrame *statusFrame = [[SLStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 将最新的数据追加到旧数据的最前面
        // 旧数据: self.statusFrames
        // 新数据: statusFrameArray
        NSMutableArray *tempArray = [NSMutableArray array];
        // 添加statusFrameArray的所有元素 添加到 tempArray中
        [tempArray addObjectsFromArray:statusFrameArray];
        // 添加self.statusFrames的所有元素 添加到 tempArray中
        [tempArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [refreshControl endRefreshing];
        
        // 显示最新微博的数量(给用户一些友善的提示)
        [self showNewStatusCount:(int)statusFrameArray.count];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 让刷新控件停止显示刷新状态
        [refreshControl endRefreshing];
    }];
    

}
/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量
 */
- (void)showNewStatusCount:(int)count
{
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // below : 下面  btn会显示在self.navigationController.navigationBar的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条新的微博", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    // 3.设置按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnX = 2;
    CGFloat btnW = self.view.frame.size.width - 2 * btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    // 4.通过动画移动按钮(按钮向下移动 btnH + 1)
    [UIView animateWithDuration:0.7 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
        
    } completion:^(BOOL finished) { // 向下移动的动画执行完毕后
        
        // 建议:尽量使用animateWithDuration, 不要使用animateKeyframesWithDuration
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 将btn从内存中移除
            [btn removeFromSuperview];
        }];
        
    }];
}




// 设置nav的item
- (void)setupNavItem
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch_os7" highIcon:@"navigationbar_friendsearch_highlighted_os7" target:self action:@selector(findFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop_os7" highIcon:@"navigationbar_pop_highlighted_os7" target:self action:@selector(pop)];
    
    // 中间按钮
    SLTitleBtn *titleBtn = [SLTitleBtn titleButton];
    // 图标
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    // 文字
    [titleBtn setTitle:@"sleen" forState:UIControlStateNormal];
    // 位置和尺寸
    titleBtn.frame = CGRectMake(0, 0, 80, 40);
    //    titleButton.tag = IWTitleButtonDownTag;
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    
    
    
    self.tableView.backgroundColor = SLColor(226, 226, 226);
   // self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SLStatusTableBorder, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)titleClick:(SLTitleBtn *)titleBtn
{
   
    if (titleBtn.tag == 0 ) {
        [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleBtn.tag = -1;
    } else {
        [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleBtn.tag = 0;
    }
}

- (void)findFriend
{
    
}
- (void)pop
{
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    // 1.创建cell
    SLStatusCell *cell = [SLStatusCell cellWithTableView:tableView];
    
    // 2.传递frame模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
    
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}




@end
