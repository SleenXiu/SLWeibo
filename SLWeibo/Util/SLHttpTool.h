//
//  SLHttpTool.h
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  封装整个项目的GET\POST请求

#import <Foundation/Foundation.h>

@class SLHttpError, SLHttpListResponse, SLHttpDictResponse;
typedef void (^SLRequestSuccess)(id json);
typedef void (^SLRequestFailure)(NSError *error);

@interface SLHttpTool : NSObject

+ (AFHTTPSessionManager *)getManager;
/**
 *  GET请求
 */
+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(SLRequestSuccess)success failure:(SLRequestFailure)failure;
/**
 *  POST请求
 */
+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(SLRequestSuccess)success failure:(SLRequestFailure)failure;
/**
 *  PATCH请求
 */
+ (void)PATCH:(NSString *)url params:(NSDictionary *)params success:(SLRequestSuccess)success failure:(SLRequestFailure)failure;
/**
 *  DELETE请求
 */
+ (void)DELETE:(NSString *)url params:(NSDictionary *)params success:(SLRequestSuccess)success failure:(SLRequestFailure)failure;

@end
