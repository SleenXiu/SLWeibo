//
//  SLTabBar.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/3.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SLTabBar;
@protocol SLTabBarDelegate <NSObject>
@optional
// 当tabbar上的按钮点击的时候会调用
- (void)tabBar:(SLTabBar *)tabbar didSelectedButtonFrom:(int)from to:(int)to;
// 当发微博按钮点击的时候调用
- (void)tabBar:(SLTabBar *)tabbar plusBtnClick:(UIButton *)btn;
@end


@interface SLTabBar : UIView

@property (nonatomic, weak) id<SLTabBarDelegate> delegate;

// 添加一个按钮（根据有多少自控制器来添加）
- (void)addBtnWithItem:(UITabBarItem *)item;
@end
