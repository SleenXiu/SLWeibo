//
//  SLAccountTool.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/5.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLAccountTool.h"
#import "SLAccount.h"
#import "SLUser.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#define IWAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
@implementation SLAccountTool

+ (void)saveAccount:(SLAccount *)account
{
    // 计算账号的过期时间
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:IWAccountFile];
}

+ (SLAccount *)account
{
    // 取出账号
    SLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:IWAccountFile];
    
    // 判断账号是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) { // 还没有过期
        return account;
    } else { // 过期
        return nil;
    }
}


@end
