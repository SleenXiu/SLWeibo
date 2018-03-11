//
//  SLStatusCell.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/6.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLStatusCell.h"
#import "SLStatusCard.h"
#import "SLStatus.h"
@interface SLStatusCell()
@end

@implementation SLStatusCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"status";
    SLStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SLStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        // cell.backgroundColor = SLColor(226, 226, 226);
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加顶部的view
        [self setupTopView];
        
    }
    return self;
}

- (void)setupTopView {
    // 0.设置cell选中时的背景
    self.selectedBackgroundView = [[UIView alloc] init];
    self.backgroundColor = [UIColor clearColor];
    
    /** 1.顶部的view */
    
}
- (void)setStatusCard:(SLStatusCard *)statusCard {
    _statusCard = statusCard;
    
    SLStatus *status = statusCard.mblog;
    self.textLabel.text = status.text;
}

@end
