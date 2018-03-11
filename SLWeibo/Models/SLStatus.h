//
//  SLStatus.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/5.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SLUser,SLStatus;
@interface SLStatus : NSObject

@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, assign) BOOL can_edit;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger textLength;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, copy) NSString *bmiddle_pic;
@property (nonatomic, copy) NSString *original_pic;
@property (nonatomic, assign) BOOL is_paid;
@property (nonatomic, assign) NSInteger mblog_vip_type;
@property (nonatomic, copy) NSString *picStatus;
@property (nonatomic, assign) NSInteger reposts_count;
@property (nonatomic, assign) NSInteger comments_count;
@property (nonatomic, assign) NSInteger attitudes_count;
@property (nonatomic, assign) NSInteger pending_approval_count;
@property (nonatomic, assign) BOOL isLongText;
@property (nonatomic, copy) NSString *rid;
@property (nonatomic, assign) NSInteger *more_info_type;
@property (nonatomic, copy) NSString *cardid;
@property (nonatomic, assign) NSInteger content_auth;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, copy) NSString *bid;
@property (nonatomic, strong) NSArray *pics;
@property (nonatomic, strong) SLUser *user;
@property (nonatomic, strong) SLStatus *retweeted_status;
@end
