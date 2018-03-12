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
@end

@implementation SLStatusPageInfo
@end


@implementation SLStatusMediaInfo
@end

@implementation SLStatusTopic
@end
