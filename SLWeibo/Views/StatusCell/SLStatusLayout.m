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
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 6.0;
    NSMutableAttributedString *temAstr = [[NSMutableAttributedString alloc] initWithString:self.status.text
                                                                                attributes:@{}];
//    temAstr.yy_lineSpacing = 6.0;
    temAstr.yy_font = kSLFont(16);
    
    SLStatusTextPositionModifier *modifier = [[SLStatusTextPositionModifier alloc] init];
    modifier.fixedLineHeight = 22;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kSLStatusCellContent_w, MAXFLOAT)];
    container.linePositionModifier = modifier;
    
    _textLayout = [YYTextLayout layoutWithContainer:container text:temAstr];
    _textHeight = _textLayout.textBoundingSize.height;
    _cellHight += _textHeight;
    
    
    
    
    
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

@implementation SLStatusTextPositionModifier
- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    if (container.verticalForm) {
        for (NSUInteger i = 0, max = lines.count; i < max; i++) {
            YYTextLine *line = lines[i];
            CGPoint pos = line.position;
            pos.x = container.size.width - container.insets.right - line.row * _fixedLineHeight - _fixedLineHeight * 0.9;
            line.position = pos;
        }
    } else {
        for (NSUInteger i = 0, max = lines.count; i < max; i++) {
            YYTextLine *line = lines[i];
            CGPoint pos = line.position;
            pos.y = line.row * _fixedLineHeight + _fixedLineHeight * 0.6 + container.insets.top;
            line.position = pos;
        }
    }
}

- (id)copyWithZone:(NSZone *)zone {
    YYTextLinePositionSimpleModifier *one = [self.class new];
    one.fixedLineHeight = _fixedLineHeight;
    return one;
}
@end
