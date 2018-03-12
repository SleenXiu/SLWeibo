//
//  SLStatusLayout.m
//  SLWeibo
//
//  Created by Sleen Xiu on 2018/3/11.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import "SLStatusLayout.h"

@implementation SLStatusLayout
+ (instancetype)statusLayoutWithStatus:(SLStatusCard *)status {
   return [[self alloc] initWithStatus:status];
}
- (instancetype)initWithStatus:(SLStatusCard *)status {
    self = [self init];
    if (self) {
        self.status = status;
        [self layout];
    }
    return self;
}
- (void)layout {
    
}
@end
