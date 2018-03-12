//
//  SLStatusCell.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/6.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@class SLStatusCard;

@interface SLStatusCellTopView : UIView
@end

@interface SLStatusCellContentView : UIView
@end

@interface SLStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) SLStatusCard *statusCard;

@property (nonatomic, strong) SLStatusCellContentView *statusView;
@end
