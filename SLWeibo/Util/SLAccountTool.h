//
//  SLAccountTool.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/5.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SLAccount, SLUser;
@interface SLAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(SLAccount *)account;

/**
 *  返回存储的账号信息
 */
+ (SLAccount *)account;

@end
