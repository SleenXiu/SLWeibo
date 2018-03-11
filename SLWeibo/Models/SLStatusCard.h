//
//  SLStatusCard.h
//  SLWeibo
//
//  Created by sleen on 2018/3/11.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SLStatus;
@interface SLStatusCard : NSObject
@property (nonatomic, assign) NSInteger card_type;
@property (nonatomic, copy)   NSString  *card_type_name;
@property (nonatomic, copy)   NSString  *itemid;
@property (nonatomic, copy)   NSString  *scheme;
@property (nonatomic, copy)   NSString  *weibo_need;
@property (nonatomic, strong) SLStatus  *mblog;
@property (nonatomic, assign) NSInteger show_type;
@end
