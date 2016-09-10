//
//  SLStatusFrame.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/6.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLStatusFrame.h"
#import "SLStatus.h"
#import "SLUser.h"
#import "SLPhotosView.h"

@implementation SLStatusFrame
/**
 *  获得微博模型数据之后, 根据微博数据计算所有子控件的frame
 */
- (void)setStatus:(SLStatus *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * SLStatusTableBorder;
    
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    // 2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = SLStatusCellBorder;
    CGFloat iconViewY = SLStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + SLStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
//    CGSize nameLabelSize = [status.user.name sizeWithFont:SLStatusNameFont];
    CGSize nameLabelSize = [status.user.name sizeWithAttributes:@{NSFontAttributeName:SLStatusNameFont}];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 4.会员图标
    if (status.user.mbtype) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + SLStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    // 5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + SLStatusCellBorder * 0.5;
//    CGSize timeLabelSize = [status.created_at sizeWithFont:SLStatusTimeFont];
    NSString *cc = status.created_at;
    CGSize timeLabelSize = [cc sizeWithAttributes:@{NSFontAttributeName:SLStatusTimeFont}];

    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    
    // 6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + SLStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
//    CGSize sourceLabelSize = [status.source sizeWithFont:SLStatusSourceFont];
    CGSize sourceLabelSize = [status.source sizeWithAttributes:@{NSFontAttributeName:SLStatusSourceFont}];
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.微博正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + SLStatusCellBorder * 0.5;
    CGFloat contentLabelMaxW = topViewW - 2 * SLStatusCellBorder;
//    CGSize contentLabelSize = [status.text sizeWithFont:SLStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];

    CGRect contentLabelRect = [status.text boundingRectWithSize:CGSizeMake(contentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SLStatusContentFont} context:nil];
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelRect.size};
    
    // 8.配图
    if (status.pic_urls.count) {
#warning 根据图片个数计算整个相册的尺寸
        CGSize photosViewSize = [SLPhotosView photosViewSizeWithPhotosCount:(int)status.pic_urls.count];
        CGFloat photosViewX = contentLabelX;
        CGFloat photosViewY = CGRectGetMaxY(_contentLabelF) + SLStatusCellBorder;
        _photosViewF = CGRectMake(photosViewX, photosViewY, photosViewSize.width, photosViewSize.height);
    }
    
    // 9.被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + SLStatusCellBorder * 0.5;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博的昵称
        CGFloat retweetNameLabelX = SLStatusCellBorder;
        CGFloat retweetNameLabelY = SLStatusCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
//        CGSize retweetNameLabelSize = [name sizeWithFont:SLRetweetStatusNameFont];
        CGSize retweetNameLabelSize = [name sizeWithAttributes:@{NSFontAttributeName:SLRetweetStatusNameFont}];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + SLStatusCellBorder * 0.5;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * SLStatusCellBorder;
//        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:SLRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        
        CGRect retweetContentLabelRect = [status.retweeted_status.text boundingRectWithSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:SLRetweetStatusContentFont} context:nil];
        
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelRect.size};
        
        // 12.被转发微博的配图
        if(status.retweeted_status.pic_urls.count) {
#warning 根据图片个数计算整个相册的尺寸
            CGSize retweetPhotosViewSize = [SLPhotosView photosViewSizeWithPhotosCount:(int)status.retweeted_status.pic_urls.count];
            CGFloat retweetPhotosViewX = retweetContentLabelX;
            CGFloat retweetPhotosViewY = CGRectGetMaxY(_retweetContentLabelF) + SLStatusCellBorder;
            _retweetPhotosViewF = CGRectMake(retweetPhotosViewX, retweetPhotosViewY, retweetPhotosViewSize.width, retweetPhotosViewSize.height);
            
            retweetViewH = CGRectGetMaxY(_retweetPhotosViewF);

        } else { // 没有配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += SLStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // 有转发微博时topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
    } else { // 没有转发微博
        if (status.pic_urls.count) { // 有图
            topViewH = CGRectGetMaxY(_photosViewF);
        } else { // 无图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += SLStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 13.工具条
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + SLStatusTableBorder;
}
@end

