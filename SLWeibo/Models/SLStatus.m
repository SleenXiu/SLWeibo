//
//  SLStatus.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/5.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLStatus.h"
#import "NSDate+MJ.h"
#import "NSString+SL.h"
#import "MJExtension.h"
#import "SLPhoto.h"
@implementation SLStatus
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pic_urls" : [SLPhoto class]};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"id":@"ID"};
}
- (NSString *)created_at {
    // _created_at == Wed Jan 06 17:33:40 +0800 2016
    // 1.获得微博的发送时间
    if (_created_at.length > 29) {
        _created_at = [NSString newDate:_created_at];
    }
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM dd H:mm:ss ZZ yyyy";
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    // 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            NSString *cc = [NSString stringWithFormat:@"%ld分钟前", createdDate.deltaWithNow.minute];
            return cc;
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}
- (void)setSource:(NSString *)source {
    unsigned long loc = [source rangeOfString:@">"].location + 1;
    unsigned long length = [source rangeOfString:@"</"].location - loc;
    source = [source substringWithRange:NSMakeRange(loc, length)];
    
    _source = [NSString stringWithFormat:@"来自%@", source];
}
@end

@implementation SLStatusPageInfo
@end


@implementation SLStatusMediaInfo
@end

@implementation SLStatusTopic
@end
