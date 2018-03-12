//
//  SLWeiboApiTool.h
//  SLWeibo
//
//  Created by sleen on 2018/3/11.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLHttpTool.h"
typedef void (^SLWeiboRequestSuccess)(NSDictionary *result);
@interface SLWeiboApiTool : NSObject
+ (void)getHotWeiboWithParam:(NSDictionary *)param success:(SLWeiboRequestSuccess)success failure:(SLRequestFailure)failure;

+ (void)test_getHotTimeLineWithParam:(NSDictionary *)param success:(SLWeiboRequestSuccess)success failure:(SLRequestFailure)failure;
@end
