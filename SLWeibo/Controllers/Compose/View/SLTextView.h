//
//  SLTextView.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/23.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SLNotificationCenter [NSNotificationCenter defaultCenter]
@interface SLTextView : UITextView
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@end
