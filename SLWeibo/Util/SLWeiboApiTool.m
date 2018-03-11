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
@end
