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
#import "SLUser.h"
#import "SLStatusLayout.h"
#import <YYText.h>


@implementation SLStatusCellTopView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.avatarView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.sourceLabel];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.frame = CGRectMake(0, 0, kSLScreenWidth, 0.5);
        line.backgroundColor = kSLColorHex(@"E6E6E6");
        [self addSubview:line];
    }
    return self;
}
- (void)setStatus:(SLStatus *)status {
    _status = status;
    
    SLUser *user = status.user;
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:user.avatar_hd]];
    
    self.nameLabel.text = user.screen_name;
    [self.nameLabel sizeToFit];
    
    self.timeLabel.text = status.created_at;
    [self.timeLabel sizeToFit];
    
    if (status.source) {
        self.sourceLabel.text = status.source;
        [self.sourceLabel sizeToFit];
        self.sourceLabel.mj_x = self.timeLabel.mj_x+self.timeLabel.mj_w+4;
    }
    
    NSLog(@"%@", NSStringFromCGRect(self.avatarView.frame));
}
#pragma mark - getter
- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.frame = CGRectMake(kSLStatusCellPadding_lr, kSLStatusCellPadding_t, kSLStatusCellAvatar_h, kSLStatusCellAvatar_h);
        _avatarView.frame = CGRectMake(12, 14, 40, 40);
        _avatarView.layer.cornerRadius = kSLStatusCellAvatar_h * 0.5;
        _avatarView.layer.borderColor = [kSLColorHex(@"E2E4E8") CGColor];
        _avatarView.layer.borderWidth = 0.5;
        _avatarView.clipsToBounds = YES;
    }
    return _avatarView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        CGFloat x = kSLStatusCellPadding_lr + kSLStatusCellAvatar_h + 6;
        _nameLabel.frame = CGRectMake(x, 16, 0, 20);
        _nameLabel.font = kSLFont(kNameFontSize);
        _nameLabel.textColor = kSLColorHex(@"FC6321");
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        CGFloat x = kSLStatusCellPadding_lr + kSLStatusCellAvatar_h + 6;
        _timeLabel.frame = CGRectMake(x, 36, 0, 0);
        _timeLabel.font = kSLFont(12);
        _timeLabel.textColor = kSLColorHex(@"929394");
    }
    return _timeLabel;
}
- (UILabel *)sourceLabel {
    if (!_sourceLabel) {
        _sourceLabel = [[UILabel alloc] init];
        CGFloat x = kSLStatusCellPadding_lr + kSLStatusCellAvatar_h + 6;
        _sourceLabel.frame = CGRectMake(x, 36, 0, 0);
        _sourceLabel.font = kSLFont(12);
        _sourceLabel.textColor = kSLColorHex(@"929394");
    }
    return _sourceLabel;
}
@end
@implementation SLStatusCellCenterView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)setStatusLayout:(SLStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    
//    _textLabel.mj_h =
}
- (YYLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[YYLabel alloc] init];
        CGFloat top = kSLStatusCellPadding_t + kSLStatusCellAvatar_h + kSLStatusCellText_t;
        _textLabel.frame = CGRectMake(kSLStatusCellPadding_lr, top, kSLStatusCellContent_w, 0);
    }
    return _textLabel;
}
@end
@implementation SLStatusCellBarView
@end




@implementation SLStatusCellContentView
- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topView];
        [self addSubview:self.centerView];
        [self addSubview:self.barView];
    }
    return self;
}
- (void)setStatusLayout:(SLStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    self.centerView.statusLayout = statusLayout;
    
    self.topView.status = statusLayout.status;
}
- (SLStatusCellTopView *)topView {
    if (!_topView) {
        _topView = [[SLStatusCellTopView alloc] init];
        _topView.frame = CGRectMake(0, 0, kSLScreenWidth, kSLStatusCellPadding_t + kSLStatusCellAvatar_h);
    }
    return _topView;
}
- (SLStatusCellCenterView *)centerView {
    if (!_centerView) {
        _centerView = [[SLStatusCellCenterView alloc] init];
    }
    return _centerView;
}
- (SLStatusCellBarView *)barView {
    if (!_barView) {
        _barView = [[SLStatusCellBarView alloc] init];
    }
    return _barView;
}
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
    
    
}
- (void)setStatusLayout:(SLStatusLayout *)statusLayout {
    _statusLayout = statusLayout;
    
    self.statusView.statusLayout = statusLayout;
    self.statusView.frame = CGRectMake(0, 0, kSLScreenWidth, statusLayout.cellHight-kSLStatusCellSpace_h);
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
