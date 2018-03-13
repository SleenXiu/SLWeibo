//
//  UIColor+SL.m
//  SLWeibo
//
//  Created by sleen on 2018/3/13.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import "UIColor+SL.h"

@implementation UIColor (SL)
static inline NSUInteger sl_hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}
static BOOL sl_hexStrToRGBA(NSString *str, CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    str = [[str stringByTrimmingCharactersInSet:set] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = sl_hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = sl_hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = sl_hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = sl_hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = sl_hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = sl_hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = sl_hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = sl_hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}
+ (instancetype)sl_colorWithHexString:(NSString *)hexStr {
    CGFloat r, g, b, a;
    if (sl_hexStrToRGBA(hexStr, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}
@end
