//
//  SLTabBarController.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/3.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLTabBarController.h"
#import "SLMeViewController.h"
#import "SLMessageViewController.h"
#import "SLDiscoverViewController.h"
#import "SLHomeViewController.h"
#import "SLTabBar.h"
#import "SLNavigationController.h"
#import "SLComposeViewController.h"
@interface SLTabBarController () <SLTabBarDelegate>
@property (nonatomic, weak) SLTabBar * mytabbar;
@end

@implementation SLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 添加自己的TarBar
    [self addTabbar];
    
    // 添加子控制器
    [self addController];
    
    self.selectedIndex = 0;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // 移除tabbar的原生子控件
    for (UIView *view in self.tabBar.subviews) {
        if (![view isKindOfClass:[SLTabBar class]]) {
            [view removeFromSuperview];
        }
    }
}
/**
 *  添加自己写的Tabbar
 */
- (void)addTabbar {
    [self.tabBar setShadowImage:[UIImage new]];
//    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    
    // 初始化自己的Tabbar
    CGRect rect = CGRectMake(0, 0, kSLScreenWidth, kSLTabBarHeight);
    SLTabBar *tabbar = [[SLTabBar alloc] initWithFrame:rect];
    // 将自己的tabbar保存起来
    self.mytabbar = tabbar;
    // 设置代理，监听tabbar上的点击事件
    tabbar.delegate = self;
    // 添加到原有的tabbar上（之后跳转到别的窗口就可以直接隐藏自己的tabbar）
    [self.tabBar addSubview:tabbar];
}
/**
 *  为TabBarController添加子控制器
 */
- (void)addController
{
    // 主页
    SLHomeViewController *home = [[SLHomeViewController alloc] init];
    [self setItemWithVc:home title:@"首页" imageName:@"tabbar_home_os7" selectImageName:@"tabbar_home_selected_os7"];
    // 发现
    SLDiscoverViewController *discover = [[SLDiscoverViewController alloc] init];
    [self setItemWithVc:discover title:@"发现" imageName:@"tabbar_discover_os7" selectImageName:@"tabbar_discover_selected_os7"];
    // 我
    SLMeViewController *me = [[SLMeViewController alloc] init];
    [self setItemWithVc:me title:@"我" imageName:@"tabbar_profile_os7" selectImageName:@"tabbar_profile_selected_os7"];
    
}

/**
 *  根据不同控制器为它的相关属性赋值
 *
 *  @param Vc          控制器
 *  @param title       tabbar与nav的标题
 *  @param image       tabba的图片
 *  @param selectImage tabbar的选中图片
 */
- (void)setItemWithVc:(UIViewController *)Vc title:(NSString *)title imageName:(NSString *)image selectImageName:(NSString *)selectImage {
    // 直接设置标题tabbar和nav都会有
    Vc.title = title;
    // 设置tabbar的图片
    Vc.tabBarItem.image = [UIImage imageNamed:image];
    // 设置tabbar的选中图片，imageWithRenderingMode系统在使用图片时不再渲染，（否则系统会搞成蓝色的）
    Vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 为子控制器包一层nav
    SLNavigationController *nv = [[SLNavigationController alloc] initWithRootViewController:Vc];
    [self addChildViewController:nv];
    
    // 为控制器添加相应得tabbar按钮
    [self.mytabbar addBtnWithItem:Vc.tabBarItem];
    
}
#pragma mark - tabbar的代理方法
- (void)tabBar:(SLTabBar *)tabbar didSelectedButtonFrom:(int)from to:(int)to {
    self.selectedIndex = to;
}
- (void)tabBar:(UITabBar *)tabBar plusBtnClick:(UIButton *)btn {
    SLComposeViewController *compose = [[SLComposeViewController alloc] init];
    SLNavigationController *nav = [[SLNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
    
}
@end
