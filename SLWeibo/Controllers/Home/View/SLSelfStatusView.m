//
//  SLSelfStatusView.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/8.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLSelfStatusView.h"
#import "SLReweetStatusView.h"
#import "SLStatusFrame.h"
#import "UIImage+SL.h"
#import "SLStatus.h"
#import "SLUser.h"
#import "UIImageView+WebCache.h"
#import "SLPhoto.h"
#import "SLPhotosView.h"
@interface SLSelfStatusView ()
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) SLPhotosView *photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) SLReweetStatusView *retweetView;
@end


@implementation SLSelfStatusView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        // 1.设置图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
        
        /** 2.头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /** 3.会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /** 4.配图 */
        SLPhotosView *photosView = [[SLPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        /** 5.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = SLStatusNameFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 6.时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = SLStatusTimeFont;
        timeLabel.textColor = SLColor(240, 140, 19);
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 7.来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = SLStatusSourceFont;
        sourceLabel.textColor = SLColor(135, 135, 135);
        sourceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 8.正文\内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = SLColor(39, 39, 39);
        contentLabel.font = SLStatusContentFont;
        contentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        /** 9.添加被转发微博的view */
        SLReweetStatusView *retweetView = [[SLReweetStatusView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    return self;
}

- (void)setStatusFrame:(SLStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.取出模型数据
    SLStatus *status = statusFrame.status;
    SLUser *user = status.user;
    
    // 2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    // 4.vip
    if (user.mbtype) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewF;
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        
        self.vipView.hidden = YES;
    }
    
    // 5.时间
    self.timeLabel.text = status.created_at;
    
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + SLStatusCellBorder * 0.5;
    //    CGSize timeLabelSize = [status.created_at sizeWithFont:SLStatusTimeFont];
    NSString *cc = status.created_at;
    CGSize timeLabelSize = [cc sizeWithAttributes:@{NSFontAttributeName:SLStatusTimeFont}];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    
    
    
    
    // 6.来源
    self.sourceLabel.text = status.source;
    
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + SLStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    //    CGSize sourceLabelSize = [status.source sizeWithFont:SLStatusSourceFont];
    CGSize sourceLabelSize = [status.source sizeWithAttributes:@{NSFontAttributeName:SLStatusSourceFont}];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};

    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 8.配图
    if (status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = self.statusFrame.photosViewF;
        
        self.photosView.photos = status.pic_urls;
        
    } else {
        self.photosView.hidden = YES;
    }
    
    // 9.被转发微博
    SLStatus *retweetStatus = status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
    } else {
        self.retweetView.hidden = YES;
    }
    
}

@end
