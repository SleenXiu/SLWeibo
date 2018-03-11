//
//  SLHttpTool.m
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "SLHttpTool.h"

static AFHTTPSessionManager *_manager;
@implementation SLHttpTool
+ (AFHTTPSessionManager *)getManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [AFHTTPSessionManager manager];
        [_manager.requestSerializer setTimeoutInterval:30];
//        [_manager.requestSerializer setValue: forHTTPHeaderField:];
    });
    return _manager;
}
+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(SLRequestSuccess)success failure:(SLRequestFailure)failure {
    AFHTTPSessionManager *manager = [self getManager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}

+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(SLRequestSuccess)success failure:(SLRequestFailure)failure {
    AFHTTPSessionManager *manager = [self getManager];
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}
+ (void)PATCH:(NSString *)url params:(NSDictionary *)params success:(SLRequestSuccess)success failure:(SLRequestFailure)failure {
    AFHTTPSessionManager *manager = [self getManager];
    [manager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}
+ (void)DELETE:(NSString *)url params:(NSDictionary *)params success:(SLRequestSuccess)success failure:(SLRequestFailure)failure {
    AFHTTPSessionManager *manager = [self getManager];
    [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ? : failure(error);
    }];
}

@end


