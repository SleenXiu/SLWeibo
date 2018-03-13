//
//  SLMeViewController.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/3.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLMeViewController.h"
#import "SLSetController.h"
@interface SLMeViewController ()

@end

@implementation SLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setBtnClick:)];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(12, 100, 40, 40);
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(12, 100, 80, 39.0);
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    
}

- (void)setBtnClick:(UIBarButtonItem *)item
{
    SLSetController *set = [[SLSetController alloc] init];
    set.title = @"设置";
    [self.navigationController pushViewController:set animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



@end
