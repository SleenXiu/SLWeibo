//
//  SLUser.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/6.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLUser.h"

@implementation SLUser
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"id":@"ID", @"description":@"desc"};
}
@end
