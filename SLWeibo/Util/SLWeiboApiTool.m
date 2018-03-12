//
//  SLWeiboApiTool.m
//  SLWeibo
//
//  Created by sleen on 2018/3/11.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import "SLWeiboApiTool.h"

NSString * const hotUrl = @"https://m.weibo.cn/api/container/getIndex?containerid=102803_ctg1_8999_-_ctg1_8999_home";
@implementation SLWeiboApiTool
+ (void)getHotWeiboWithParam:(NSDictionary *)param success:(SLWeiboRequestSuccess)success failure:(SLRequestFailure)failure {
    [SLHttpTool GET:hotUrl params:param success:^(id json) {
        !success?:success(json);
    } failure:failure];
}

+ (void)test_getHotTimeLineWithParam:(NSDictionary *)param success:(SLWeiboRequestSuccess)success failure:(SLRequestFailure)failure {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"unread_hot_timeline" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        failure(error);
    } else {
        success(result);
    }
}
@end
