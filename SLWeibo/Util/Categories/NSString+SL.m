//
//  NSString+SL.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/6.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "NSString+SL.h"

@implementation NSString (SL)

+ (NSString *)newDate:(NSString *)date
{
    // _created_at == Wed Jan 06 17:33:40 +0800 2016
    // 1.获得发送时间
    // fmt.dateFormat = @"MM dd H:mm:ss ZZ yyyy";
    NSString *mouthT = [date substringWithRange:(NSRange){4,3}];
    NSString *temp = [date substringFromIndex:7];
    NSArray *mouths = @[@"Jan", @"Feb", @"Mar", @"Aay", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
    NSString *mouth = @"";
    for (int i = 0; i<12; i++) {
        if ([mouthT isEqualToString:mouths[i]]) {
            mouth = [NSString stringWithFormat:@"%02d", i+1];
        }
    }
    return [mouth stringByAppendingString:temp];
}
@end
