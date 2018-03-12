//
//  SLStatusCell.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/6.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@class SLStatusLayout, SLStatusCard, SLStatus, YYLabel;

@interface SLStatusCellTopView : UIView
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIImageView *bagdeView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *sourceLabel;

@property (nonatomic, strong) SLStatus *status;
@end
@interface SLStatusCellCenterView : UIView
@property (nonatomic, strong) YYLabel *textLabel;

@property (nonatomic, strong) SLStatusLayout *statusLayout;
@end
@interface SLStatusCellBarView : UIView
@property (nonatomic, strong) UIButton *shareButton;
@end

@interface SLStatusCellContentView : UIView
@property (nonatomic, strong) SLStatusCellTopView *topView;
@property (nonatomic, strong) SLStatusCellCenterView *centerView;
@property (nonatomic, strong) SLStatusCellBarView *barView;


@property (nonatomic, strong) SLStatusLayout *statusLayout;
@end

@interface SLStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) SLStatusCard *statusCard;
@property (nonatomic, strong) SLStatusLayout *statusLayout;

@property (nonatomic, strong) SLStatusCellContentView *statusView;
@end
