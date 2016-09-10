//
//  SLComposeToolbar.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/23.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLComposeToolbar;

typedef enum {
    SLComposeToolbarButtonTypeCamera,
    SLComposeToolbarButtonTypePicture,
    SLComposeToolbarButtonTypeMention,
    SLComposeToolbarButtonTypeTrend,
    SLComposeToolbarButtonTypeEmotion
} SLComposeToolbarButtonType;

@protocol SLComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(SLComposeToolbar *)toolbar didClickedButton:(SLComposeToolbarButtonType)buttonType;
@end

@interface SLComposeToolbar : UIView
@property (weak, nonatomic) id<SLComposeToolbarDelegate> delegate;
@end
