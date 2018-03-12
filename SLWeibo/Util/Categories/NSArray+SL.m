//
//  NSArray+SL.m
//  SLWeibo
//
//  Created by sleen on 2018/3/12.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import "NSArray+SL.h"

@implementation NSArray (SL)
#ifdef DEBUG
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}
#endif
@end
