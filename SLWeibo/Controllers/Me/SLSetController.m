
//
//  SLSetController.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/3/4.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLSetController.h"

@implementation SLSetController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    return cell;
}
@end
