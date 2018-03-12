//
//  SLStatusLayout.h
//  SLWeibo
//
//  Created by Sleen Xiu on 2018/3/11.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SLStatusCard;
@interface SLStatusLayout : NSObject
+ (instancetype)statusLayoutWithStatus:(SLStatusCard *)status;
- (instancetype)initWithStatus:(SLStatusCard *)status;
- (void)layout;

@property (nonatomic, strong) SLStatusCard *status;

@property (nonatomic, assign) CGFloat cellHight;
@end
