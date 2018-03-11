//
//  SLUser.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/6.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLUser : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *profile_image_url;
@property (nonatomic, copy) NSString *profile_url;
@property (nonatomic, assign) NSInteger statuses_count;
@property (nonatomic, assign) BOOL verified;
@property (nonatomic, assign) NSInteger verified_type;
@property (nonatomic, assign) NSInteger verified_type_ext;
@property (nonatomic, copy) NSString *verified_reason;
@property (nonatomic, assign) BOOL close_blue_v;
@property (nonatomic, copy) NSString *desc; //description
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, assign) NSInteger mbtype;
@property (nonatomic, assign) NSInteger urank;
@property (nonatomic, assign) BOOL follow_me;
@property (nonatomic, assign) BOOL following;
@property (nonatomic, assign) NSInteger followers_count;
@property (nonatomic, assign) NSInteger followe_count;
@property (nonatomic, copy) NSString *cover_image_phone;
@property (nonatomic, copy) NSString *avatar_hd;
@property (nonatomic, assign) BOOL like;
@property (nonatomic, assign) BOOL like_me;
@property (nonatomic, strong) NSDictionary *badge;
@end
