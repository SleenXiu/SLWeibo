//
//  SLTabBar.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/3.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLTabBar.h"
#import "SLTabBarButton.h"

@interface SLTabBar ()
@property (nonatomic, weak) SLTabBarButton * selectedBtnNow;
@property (nonatomic, strong) NSMutableArray *tabbarBtns;
@end


@implementation SLTabBar

- (NSMutableArray *)tabbarBtns
{
    if (_tabbarBtns == nil) {
        _tabbarBtns = [NSMutableArray array];
    }
    return _tabbarBtns;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_background"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_background_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
//        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateHighlighted];
        plusBtn.frame = CGRectMake(0, 0, plusBtn.currentBackgroundImage.size.width, plusBtn.currentBackgroundImage.size.height);
        [plusBtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
    }
    return self;
}

- (void)btnclick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(tabBar: plusBtnClick: )]) {
        [self.delegate tabBar:self plusBtnClick:btn];
    }
}





- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.subviews[0].center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    // 布局按钮的位置
    for (int index = 0; index<self.tabbarBtns.count; index++ ) {
        
        SLTabBarButton *btn = self.tabbarBtns[index];
        
        CGFloat bW = self.frame.size.width / self.subviews.count;
        CGFloat bH = self.frame.size.height;
        CGFloat bX = index * bW;
        CGFloat bY = 0;
        if (index>1) {
            bX += bW;
        }
        btn.frame = CGRectMake(bX, bY, bW, bH);
        btn.tag = index; // 绑定tag，方便以后的跳转
    }
}

- (void)addBtnWithItem:(UITabBarItem *)item
{
    // 创建一个自定义的按钮
    SLTabBarButton *btn = [[SLTabBarButton alloc] init];
    // 监听事件
    [btn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    // 为按钮item模型赋值
    btn.item = item;
    // 添加
    [self addSubview:btn];
    [self.tabbarBtns addObject:btn];
    // 默认选中第一个
    if (self.tabbarBtns.count == 1) {
        [self selectedBtn:btn];
    }
    
}
// 按钮的点击事件
- (void)selectedBtn:(SLTabBarButton *)btn
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar: didSelectedButtonFrom: to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedBtnNow.tag to:(int)btn.tag];
    }
    // 设置tabbar的选中
    self.selectedBtnNow.selected = NO;
    btn.selected = YES;
    self.selectedBtnNow = btn;

}








@end
