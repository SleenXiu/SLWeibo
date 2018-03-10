//
//  SLAuthorController.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/4.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLAuthorController.h"
#import "AFNetworking.h"
#import "SLTabBarController.h"
#import "SLNewPartController.h"
#import "SLAccount.h"
#import "SLAccountTool.h"
#import "SLWeiboTool.h"
@interface SLAuthorController () <UIWebViewDelegate>
@end
@implementation SLAuthorController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.加载授权页面
    NSURL *url =[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3379169445&redirect_uri=http://www.sleen.xyz"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - webView的代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.请求的url路径：http://www.sleen.xyz/?code=f9dc535d8e94ae4c5cfca425cba9f6a9
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code=在urtStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 3.如果urlStr中包含code=
    if (range.length) {
        // 4.截取code=后面的请求标记
        unsigned long loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
        // 5.发送POST请求，获得accessToken
        [self accessTokenWithCode:code];
    }
    
    return YES;
}
/**
 *  通过code获得一个accessToken，并存储到沙盒中
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 使用第三方框架：AFNetworking
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.封装请求参数，新浪要求传的参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3379169445";
    params[@"client_secret"] = @"d8b24adf483483ddf049cf9198f4f3ef";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.sleen.xyz";
    
    // 3.发请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params
     progress:^(NSProgress * _Nonnull uploadProgress) {
         
    }
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
          // 4.先将字典转为模型
          SLAccount *account = [SLAccount accountWithDict:responseObject];
          
          // 5.存储模型数据
          [SLAccountTool saveAccount:account];
          
          // 6.新特性\去首页
          [SLWeiboTool chooseRootController];
    }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"succ____%@", error);
    }];
    
    
}












@end
