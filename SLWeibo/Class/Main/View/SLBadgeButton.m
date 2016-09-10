//
//  SLBadgeButton.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/4.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLBadgeButton.h"
#import "UIImage+SL.h"
@implementation SLBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
#warning copy
    //    _badgeValue = badgeValue;
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            // CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            CGSize badgeSize  = [badgeValue sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}
@end
