//
//  SLComposeToolbar.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/23.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLComposeToolbar.h"

@implementation SLComposeToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background_os7"]];
        
        // 2.添加按钮
        [self addButtonWithIcon:@"compose_camerabutton_background_os7" highIcon:@"compose_camerabutton_background_highlighted_os7" tag:SLComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture_os7" highIcon:@"compose_toolbar_picture_highlighted_os7" tag:SLComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background_os7" highIcon:@"compose_mentionbutton_background_highlighted_os7" tag:SLComposeToolbarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background_os7" highIcon:@"compose_trendbutton_background_highlighted_os7" tag:SLComposeToolbarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background_os7" highIcon:@"compose_emoticonbutton_background_highlighted_os7" tag:SLComposeToolbarButtonTypeEmotion];
    }
    return self;
}

- (void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(int)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickedButton:)]) {
        [self.delegate composeToolbar:self didClickedButton:(int)button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
    }
}

@end

