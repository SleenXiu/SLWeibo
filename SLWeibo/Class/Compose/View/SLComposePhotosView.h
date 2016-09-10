//
//  SLComposePhoto.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/23.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLComposePhotosView : UIView
/**
 *  添加一张新的图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  返回内部所有的图片
 */
- (NSArray *)totalImages;
@end
