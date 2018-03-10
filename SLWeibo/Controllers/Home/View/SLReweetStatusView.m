//
//  SLReweetStatusView.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/8.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLReweetStatusView.h"
#import "UIImage+SL.h"
#import "SLStatusFrame.h"
#import "SLStatus.h"
#import "SLUser.h"
#import "UIImageView+WebCache.h"
#import "SLPhoto.h"
#import "SLPhotosView.h"
@interface SLReweetStatusView()
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) SLPhotosView *retweetPhotoView;
@end

@implementation SLReweetStatusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        // 1.设置图片
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background_os7" left:0.9 top:0.5];
        
        /** 2.被转发微博作者的昵称 */
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = SLRetweetStatusNameFont;
        retweetNameLabel.textColor = SLColor(67, 107, 163);
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        /** 3.被转发微博的正文\内容 */
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.font = SLRetweetStatusContentFont;
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        retweetContentLabel.numberOfLines = 0;
        retweetContentLabel.textColor = SLColor(90, 90, 90);
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        /** 4.被转发微博的配图 */
        SLPhotosView *retweetPhotoView = [[SLPhotosView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
    }
    return self;
}

- (void)setStatusFrame:(SLStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    SLStatus *retweetStatus = statusFrame.status.retweeted_status;
    SLUser *user = retweetStatus.user;
    
    // 1.昵称
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    
    // 2.正文
    self.retweetContentLabel.text = retweetStatus.text;
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    
    // 3.配图
    if (retweetStatus.pic_urls.count) {
        self.retweetPhotoView.hidden = NO;
        self.retweetPhotoView.frame = self.statusFrame.retweetPhotosViewF;
        self.retweetPhotoView.photos = retweetStatus.pic_urls;
        
    } else {
        self.retweetPhotoView.hidden = YES;
    }
}

@end

