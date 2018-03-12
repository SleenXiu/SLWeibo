//
//  SLWeiboTool.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/5.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLWeiboTool.h"
#import "AppDelegate.h"
#import "SLTabBarController.h"
#import "SLNewPartController.h"
@implementation SLWeiboTool
+ (void)chooseRootController
{
    
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[SLTabBarController alloc] init];
    } else { // 新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[SLNewPartController alloc] init];
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}
@end
