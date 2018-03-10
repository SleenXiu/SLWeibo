//
//  SLStatusFrame.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/6.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/** 昵称的字体 */
#define SLStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define SLRetweetStatusNameFont SLStatusNameFont

/** 时间的字体 */
#define SLStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define SLStatusSourceFont SLStatusTimeFont

/** 正文的字体 */
#define SLStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define SLRetweetStatusContentFont SLStatusContentFont

/** 表格的边框宽度 */
#define SLStatusTableBorder 5

/** cell的边框宽度 */
#define SLStatusCellBorder 10

@class SLStatus;
@interface SLStatusFrame : NSObject
@property (nonatomic, strong) SLStatus *status;

/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photosViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;

/** 被转发微博的view(父控件) */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/** 被转发微博作者的昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/** 被转发微博的配图 */
@property (nonatomic, assign, readonly) CGRect retweetPhotosViewF;

/** 微博的工具条 */
@property (nonatomic, assign, readonly) CGRect statusToolbarF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end

