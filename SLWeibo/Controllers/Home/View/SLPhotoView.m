//
//  SLPhotoView.m
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/11.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import "SLPhotoView.h"
#import "UIImageView+WebCache.h"
#import "SLStatus.h"
@interface SLPhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation SLPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加一个GIF小图片
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}
- (void)setPhoto:(SLStatusPicutre *)photo {
    _photo = photo;
    
    self.gifView.hidden = ![photo.thumbnail.type hasSuffix:@"gif"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail.url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}

@end

