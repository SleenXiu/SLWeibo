//
//  SLNavigationController.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/4.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLNavigationController.h"

@implementation SLNavigationController

/**
 *  第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    // 设置导航栏主题
    [self setupNavBar];
    // 设置按钮的主题
    [self setupNavBarItem];
}
// 设置导航栏主题
+ (void)setupNavBar
{
    // 取出当前的bar
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor]; // 文字颜色
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19]; // 文字字体
    [bar setTitleTextAttributes:textAttrs];
}
// 设置按钮的主题
+ (void)setupNavBarItem
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] =  [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
}

// 在push的时候拦截，隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 第一个root控制器不需要拦截
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
