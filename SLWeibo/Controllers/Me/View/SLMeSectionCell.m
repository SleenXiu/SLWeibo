//
//  SLMeSectionCell.m
//  SLWeibo
//
//  Created by QMP on 2018/4/15.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import "SLMeSectionCell.h"

@implementation SLMeSectionCell
+ (SLMeSectionCell *)meSectionCellWithTableView:(UITableView *)tableView {
    SLMeSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SLMeSectionCell__sl"];
    if (cell) {
        cell = [[SLMeSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SLMeSectionCell__sl"];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
