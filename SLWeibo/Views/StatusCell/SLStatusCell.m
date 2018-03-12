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


@implementation SLStatusCellTopView
@end

@implementation SLStatusCellContentView
@end


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
        self.selectedBackgroundView = [[UIView alloc] init];
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.statusView];
    }
    return self;
}


- (void)setStatusCard:(SLStatusCard *)statusCard {
    _statusCard = statusCard;
    
    SLStatus *status = statusCard.mblog;
    self.textLabel.text = status.text;
}
#pragma mark - getter
- (SLStatusCellContentView *)statusView {
    if (!_statusView) {
        _statusView = [[SLStatusCellContentView alloc] init];
        _statusView.backgroundColor = [UIColor whiteColor];
    }
    return _statusView;
}
@end
