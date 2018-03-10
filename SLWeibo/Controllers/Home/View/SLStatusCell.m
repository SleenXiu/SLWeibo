//
//  SLStatusCell.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/6.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLStatusCell.h"
#import "SLStatusFrame.h"
#import "SLStatus.h"
#import "SLUser.h"
#import "UIImage+SL.h"
#import "UIImageView+WebCache.h"
#import "SLStatusToolBar.h"
#import "SLSelfStatusView.h"

@interface SLStatusCell()
/** 顶部的view */
@property (nonatomic, weak) SLSelfStatusView *topView;

/** 微博的工具条 */
@property (nonatomic, weak) SLStatusToolBar *statusToolBar;
@end

@implementation SLStatusCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    SLStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SLStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        // cell.backgroundColor = SLColor(226, 226, 226);
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加顶部的view
        [self setupTopView];
        
        // 2.添加微博的工具条
        [self setupStatusToolBar];
    }
    return self;
}

/**
 *  添加顶部的view
 */
- (void)setupTopView
{
    // 0.设置cell选中时的背景
    self.selectedBackgroundView = [[UIView alloc] init];
    self.backgroundColor = [UIColor clearColor];
    
    /** 1.顶部的view */
    SLSelfStatusView *topView = [[SLSelfStatusView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar
{
    /** 微博的工具条 */
    SLStatusToolBar *statusToolBar = [[SLStatusToolBar alloc] init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
}

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += SLStatusTableBorder;
    frame.origin.x = SLStatusTableBorder;
    frame.size.width -= 2 * SLStatusTableBorder;
    frame.size.height -= SLStatusTableBorder;
    [super setFrame:frame];
}

#pragma mark - 数据的设置
/**
 *  传递模型数据
 */
- (void)setStatusFrame:(SLStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.设置顶部view的数据
    [self setupTopViewData];
    
    // 2.设置微博工具条的数据
    [self setupStatusToolBarData];
    
}

/**
 *  设置顶部view的数据
 */
- (void)setupTopViewData
{
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    // 2.传递模型数据
    self.topView.statusFrame = self.statusFrame;
}

/**
 *  设置微博工具条的数据
 */
- (void)setupStatusToolBarData
{
    self.statusToolBar.frame = self.statusFrame.statusToolbarF;
    self.statusToolBar.status = self.statusFrame.status;
}
@end
