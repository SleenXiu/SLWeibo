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
        _photoSize = [SLPhotosView photosViewSizeWithPhotosCount:(int)status.pic_ids.count];
        _cellHight += _photoSize.height;
    } else if ([status.page_info.type isEqualToString:@"video"]) {
        _cellHight += (kSLStatusCellContent_w * kSLStatusCellMedia_scale);
    }
    
    _cellHight += kSLStatusCellBar_t;
    _cellHight += kSLStatusCellBar_h;
    _cellHight += kSLStatusCellSpace_h;
}
- (void)fixText:(NSString *)text {
   
    
    
}
//- (NSAttributedString *)_fixTextWithStatus:(SLStatus *)status fontSize:(CGFloat) fontSize textColor:(UIColor *)textColor {
//    NSMutableString *string = status.text.copy;
//
//    UIFont *font = kSLFont(fontSize);
//
//    YYTextBorder *highlightBorder = [[YYTextBorder alloc] init];
//    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
//    highlightBorder.cornerRadius = 3;
//    highlightBorder.fillColor = kSLColorHex(@"BECDDB");
//
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
//    text.yy_font = font;
//    text.yy_color = textColor;
//
//    for (SLStatusUrlStruct *urlStruct in status.url_struct) {
//        if (urlStruct.url_title.length == 0) continue ;
//        if (urlStruct.short_url.length == 0) continue ;
//
//        NSString *urlTitle = urlStruct.url_title;
//
//        NSRange searchRange = NSMakeRange(0, text.string.length);
//        do {
//            NSRange range = [text.string rangeOfString:urlStruct.short_url options:kNilOptions range:searchRange];
//            if (range.location == NSNotFound) break;
//
//
////            if ([text yy_attribute:YYTextHighlightAttributeName atIndex:range.location] == nil) {
////
////                // 替换的内容
////                NSMutableAttributedString *replace = [[NSMutableAttributedString alloc] initWithString:urlTitle];
////                if (urlStruct.url_type_pic.length) {
////                    // 链接头部有个图片附件 (要从网络获取)
////                    NSURL *picURL = [NSURL URLWithString:urlStruct.url_type_pic];
////                    NSAttributedString *pic = [self _attachmentWithFontSize:fontSize imageURL:wburl.urlTypePic shrink:YES];
////                    [replace insertAttributedString:pic atIndex:0];
////                }
////
////            }
//        } while (1);
//    }
//}

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
            pos.y = line.row * _fixedLineHeight + _fixedLineHeight * 0.7 + container.insets.top;
            line.position = pos;
        }
    }
}

- (id)copyWithZone:(NSZone *)zone {
    SLStatusTextPositionModifier *one = [self.class new];
    one.fixedLineHeight = _fixedLineHeight;
    return one;
}
@end
