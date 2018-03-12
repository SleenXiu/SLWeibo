//
//  SLStatusLayout.m
//  SLWeibo
//
//  Created by Sleen Xiu on 2018/3/11.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import "SLStatusLayout.h"
#import "SLStatus.h"
#import "SLPhotosView.h"
#import <YYText.h>
@implementation SLStatusLayout
+ (instancetype)statusLayoutWithStatus:(SLStatus *)status {
   return [[self alloc] initWithStatus:status];
}
- (instancetype)initWithStatus:(SLStatus *)status {
    self = [self init];
    if (self) {
        self.status = status;
        [self layout];
    }
    return self;
}
- (void)layout {
    _cellHight = 0;
    
    _cellHight += kSLStatusCellPadding_t;
    _cellHight += kSLStatusCellAvatar_h;
    _cellHight += kSLStatusCellText_t;
    
    SLStatus *status = self.status;
    _cellHight += [self sizeWithText:status.text andFont:kSLFont(kTextFontSize) maxWidth:kSLScreenWidth-2*kSLStatusCellPadding_lr].height;
//    YYTextLayout *textLayout = [[YYTextLayout alloc] init];
    
    
    
    
    if (status.pic_ids.count > 0) {
        _cellHight += kSLStatusCellMedia_t;
        _cellHight += [SLPhotosView photosViewSizeWithPhotosCount:(int)status.pic_ids.count].height;
    } else if ([status.page_info.type isEqualToString:@"video"]) {
        _cellHight += (kSLStatusCellContent_w * kSLStatusCellMedia_scale);
    }
    
    _cellHight += kSLStatusCellBar_t;
    _cellHight += kSLStatusCellBar_h;
    _cellHight += kSLStatusCellSpace_h;
}
- (void)fixText:(NSString *)text {
   
    
    
}
- (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font maxWidth:(CGFloat)width{
    if (text.length < 1) {
        return CGSizeZero;
    }
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 6.0;
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text
                                                                 attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
    label.attributedText = string;
    [label sizeThatFits:CGSizeMake(width, 100)];
    return label.bounds.size;
}
@end
