//
//  SLAccount.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/4.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLAccount.h"

@implementation SLAccount
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires_in"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
        self.expiresTime = [decoder decodeObjectForKey:@"expiresTime"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [encoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [encoder encodeInt64:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expiresTime forKey:@"expiresTime"];
}

@end
